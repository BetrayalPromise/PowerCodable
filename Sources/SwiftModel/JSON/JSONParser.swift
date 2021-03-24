

#if os(Linux)
import SwiftGlibc.C
#else
import Darwin.C
#endif

import Foundation

extension JSON {
    public struct Parser {
        public struct Option: OptionSet {
            public init(rawValue: UInt8) { self.rawValue = rawValue }
            public let rawValue: UInt8

            /// Omit null values from `JSON.object`s & `JSON.array`s
            public static let omitNulls       = Option(rawValue: 0b0001)

            /// Allows Parser to return top level objects that are not container types `{}` | `[]` as per RFC7159
            public static let allowFragments  = Option(rawValue: 0b0010)

            /// Allow the Parser to remove comments
            public static let allowComments   = Option(rawValue: 0b0100)
        }

        let omitNulls: Bool
        let allowComments: Bool

        var pointer: UnsafePointer<UTF8.CodeUnit>
        var buffer: UnsafeBufferPointer<UTF8.CodeUnit>

        /// Used to reduce the number of alloc's for parsing subsequent strings
        var stringBuffer: [UTF8.CodeUnit] = []
    }
}


// MARK: - Initializers

extension JSON.Parser {
    // assumes data is null terminated.
    // and that the buffer will not be de-allocated before completion (handled by JSON.Parser.parse(_:,options:)
    internal init(bufferPointer: UnsafeBufferPointer<UTF8.CodeUnit>, options: Option) throws {
        self.buffer = bufferPointer

        guard let pointer = bufferPointer.baseAddress, buffer.endAddress != bufferPointer.baseAddress else {
            throw Error(byteOffset: 0, reason: .emptyStream)
        }

        self.pointer = pointer
        self.omitNulls = options.contains(.omitNulls)
        self.allowComments = options.contains(.allowComments)
    }
}


// MARK: - Public API

extension JSON.Parser {
    public static func parse(_ buffer: UnsafeBufferPointer<UTF8.CodeUnit>, options: Option = []) throws -> JSON {
        var parser = try JSON.Parser(bufferPointer: buffer, options: options)
        do {
            try parser.skipWhitespace()
            let rootValue = try parser.parseValue()
            if !options.contains(.allowFragments) {
                switch rootValue {
                case .array(_), .object(_): break
                default: throw Error.Reason.fragmentedJson
                }
            }

            // TODO (vkda): option to skip the trailing data check, useful for say streams see Jay's model
            try parser.skipWhitespace()

            guard parser.pointer == parser.buffer.endAddress else { throw Error.Reason.invalidSyntax }

            return rootValue
        } catch let error as Error.Reason {
            // We unwrap here because on we do this check prior to the do { } catch { } block.
            throw Error(byteOffset: parser.buffer.baseAddress!.distance(to: parser.pointer), reason: error)
        }
    }
}

extension JSON.Parser {
    public static func parse(_ data: Data, options: Option = []) throws -> JSON {
        #if swift(>=5)
        return try data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> JSON in
            let buffer: UnsafeBufferPointer<UTF8.CodeUnit> = pointer.bindMemory(to: UTF8.CodeUnit.self)
            return try JSON.Parser.parse(buffer, options: options)
        }
        #else
        return try data.withUnsafeBytes { (pointer: UnsafePointer<UTF8.CodeUnit>) in
            let buffer: UnsafeBufferPointer<UTF8.CodeUnit> = UnsafeBufferPointer(start: pointer, count: data.count)
            return try JSON.Parser.parse(buffer, options: options)
        }
        #endif
    }

    public static func parse(_ data: [UTF8.CodeUnit], options: Option = []) throws -> JSON {
        return try data.withUnsafeBufferPointer { (pointer: UnsafeBufferPointer<UTF8.CodeUnit>) in
            return try JSON.Parser.parse(pointer, options: options)
        }
    }

    public static func parse(_ string: String, options: Option = []) throws -> JSON {
        let data = Array(string.utf8)
        return try JSON.Parser.parse(data, options: options)
    }
}


// MARK: - Internals

extension JSON.Parser {
    func peek(aheadBy n: Int = 0) -> UTF8.CodeUnit? {
        guard pointer.advanced(by: n) < buffer.endAddress else {
            return nil
        }
        return pointer.advanced(by: n).pointee
    }

    func hasPrefix(_ prefix: [UTF8.CodeUnit]) -> Bool {
        for (index, byte) in prefix.enumerated() {
            guard byte == peek(aheadBy: index) else { return false }
        }
        return true
    }

    /// - Precondition: pointer != buffer.endAddress. It is assumed before calling pop that you have
    @discardableResult
    mutating func pop() -> UTF8.CodeUnit {
        assert(pointer != buffer.endAddress)
        defer { pointer = pointer.advanced(by: 1) }
        return pointer.pointee
    }
}

extension JSON.Parser {
    mutating func skipWhitespace() throws {
        /// Returns whether a comment was skipped
        func skipComments() throws -> Bool {
            if hasPrefix(LegalCharacters.lineComment) {
                while let char = peek(), char != LegalCharacters.newline {
                    pop()
                }
                return true
            } else if hasPrefix(LegalCharacters.blockCommentStart) {
                // don't be mislead by `/*/`.
                pop() // '/'
                pop() // '*'

                var depth: UInt = 1
                repeat {
                    guard peek() != nil else {
                        throw Error.Reason.unmatchedComment
                    }
                    if hasPrefix(LegalCharacters.blockCommentEnd) {
                        depth -= 1
                    } else if hasPrefix(LegalCharacters.blockCommentStart) {
                        depth += 1
                    }

                    pop()
                } while depth > 0
                pop() // '/'
                return true
            }
            return false
        }

        while pointer != buffer.endAddress && pointer.pointee.isWhitespace  {
            pop()
        }
        if allowComments {
            let wasComment = try skipComments()
            if wasComment { try skipWhitespace() }
        }
    }
}

extension JSON.Parser {
    /**
     - precondition: `pointer` is at the beginning of a literal
     - postcondition: `pointer` will be in the next non-`whiteSpace` position
     */
    mutating func parseValue() throws -> JSON {
        assert(!pointer.pointee.isWhitespace)

        defer { _ = try? skipWhitespace() }
        switch peek() {
        case LegalCharacters.objectOpen?:
            let object = try parseObject()
            return object
        case LegalCharacters.arrayOpen?:
            let array = try parseArray()
            return array
        case LegalCharacters.quote?:
            let string = try parseString()
            return .string(string)
        case LegalCharacters.minus?, LegalCharacters.numbers?:
            let number = try parseNumber()
            return number
        case LegalCharacters.f?:
            pop()
            try assertFollowedBy(LegalCharacters.alse)
            return .bool(false)
        case LegalCharacters.t?:
            pop()
            try assertFollowedBy(LegalCharacters.rue)
            return .bool(true)
        case LegalCharacters.n?:
            pop()
            try assertFollowedBy(LegalCharacters.ull)
            return .null
        case LegalCharacters.slash? where allowComments:
            try skipWhitespace()
            return try parseValue()
        default:
            throw Error.Reason.invalidSyntax
        }
    }

    mutating func assertFollowedBy(_ chars: [UTF8.CodeUnit]) throws {
        for scalar in chars {
            guard scalar == pop() else { throw Error.Reason.invalidLiteral }
        }
    }

    mutating func parseObject() throws -> JSON {
        assert(peek() == LegalCharacters.objectOpen)
        pop()
        try skipWhitespace()
        guard peek() != LegalCharacters.objectClose else {
            pop()
            return .object([:])
        }

        var tempDict: [String: JSON] = Dictionary(minimumCapacity: 6)
        var wasComma = false

        repeat {
            switch peek() {
            case LegalCharacters.comma?:
                guard !wasComma else { throw Error.Reason.trailingComma }
                wasComma = true
                pop()
                try skipWhitespace()
            case LegalCharacters.quote?:
                if tempDict.count > 0 && !wasComma {
                    throw Error.Reason.expectedComma
                }
                let key = try parseString()
                try skipWhitespace()
                guard pop() == LegalCharacters.colon else { throw Error.Reason.expectedColon }
                try skipWhitespace()
                let value = try parseValue()
                wasComma = false
                switch value {
                case .null where omitNulls:
                    break
                default:
                    tempDict[key] = value
                }
            case LegalCharacters.objectClose?:
                guard !wasComma else { throw Error.Reason.trailingComma }
                pop()
                return .object(tempDict)
            default:
                throw Error.Reason.invalidSyntax
            }
        } while true
    }

    mutating func parseArray() throws -> JSON {
        assert(peek() == LegalCharacters.arrayOpen)
        pop()
        try skipWhitespace()

        // Saves the allocation of the tempArray
        guard peek() != LegalCharacters.arrayClose else {
            pop()
            return .array([])
        }

        var tempArray: [JSON] = []
        tempArray.reserveCapacity(6)
        var wasComma = false
        repeat {
            switch peek() {
            case LegalCharacters.comma?:
                guard !wasComma else { throw Error.Reason.invalidSyntax }
                guard tempArray.count > 0 else { throw Error.Reason.invalidSyntax }
                wasComma = true
                try skipComma()
            case LegalCharacters.arrayClose?:
                guard !wasComma else { throw Error.Reason.trailingComma }
                _ = pop()
                return .array(tempArray)
            case nil:
                throw Error.Reason.endOfStream
            default:
                if tempArray.count > 0 && !wasComma {
                    throw Error.Reason.expectedComma
                }
                let value = try parseValue()
                try skipWhitespace()
                wasComma = false
                switch value {
                case .null where omitNulls:
                    if peek() == LegalCharacters.comma {
                        try skipComma()
                        wasComma = true
                    }
                default:
                    tempArray.append(value)
                }
            }
        } while true
    }

    mutating func parseNumber() throws -> JSON {
        assert(LegalCharacters.numbers ~= peek()! || LegalCharacters.minus == peek()!)
        var seenExponent = false
        var seenDecimal = false
        let negative: Bool = {
            guard LegalCharacters.minus == peek() else { return false }
            pop()
            return true
        }()
        guard let next = peek(), LegalCharacters.numbers ~= next else { throw Error.Reason.invalidNumber }
        // Checks for leading zero's on numbers that are not '0' or '0.x'
        if next == LegalCharacters.zero {
            guard let following = peek(aheadBy: 1) else {
                pop()
                return .integer(0)
            }
            switch following {
            case LegalCharacters.decimal, LegalCharacters.e, LegalCharacters.E: break
            case _ where following.isTerminator: break
            default: throw Error.Reason.invalidNumber
            }
        }

        var significand: UInt64 = 0
        var mantisa: UInt64 = 0
        var divisor: Double = 10
        var exponent: UInt64 = 0
        var negativeExponent = false
        var didOverflow: Bool
        repeat {
            switch peek() {
            case LegalCharacters.numbers? where !seenDecimal && !seenExponent:
                (significand, didOverflow) = significand.multipliedReportingOverflow(by: 10)
                guard !didOverflow else { throw Error.Reason.numberOverflow }

                (significand, didOverflow) = significand.addingReportingOverflow(UInt64(pop() - LegalCharacters.zero))
                guard !didOverflow else { throw Error.Reason.numberOverflow }
            case LegalCharacters.numbers? where seenDecimal && !seenExponent:
                divisor *= 10
                (mantisa, didOverflow) = mantisa.multipliedReportingOverflow(by: 10)
                guard !didOverflow else { throw Error.Reason.numberOverflow }
                (mantisa, didOverflow) = mantisa.addingReportingOverflow(UInt64(pop() - LegalCharacters.zero))
                guard !didOverflow else { throw Error.Reason.numberOverflow }
            case LegalCharacters.numbers? where seenExponent:
                (exponent, didOverflow) = exponent.multipliedReportingOverflow(by: 10)
                guard !didOverflow else { throw Error.Reason.numberOverflow }
                (exponent, didOverflow) = exponent.addingReportingOverflow(UInt64(pop() - LegalCharacters.zero))
                guard !didOverflow else { throw Error.Reason.numberOverflow }
            case LegalCharacters.decimal? where !seenExponent && !seenDecimal:
                pop()
                seenDecimal = true
                guard let next = peek(), LegalCharacters.numbers ~= next else { throw Error.Reason.invalidNumber }
            case LegalCharacters.E? where !seenExponent,
                 LegalCharacters.e? where !seenExponent:
                pop()
                seenExponent = true
                if peek() == LegalCharacters.minus {
                    negativeExponent = true
                    pop()
                } else if peek() == LegalCharacters.plus {
                    pop()
                }
                guard let next = peek(), LegalCharacters.numbers ~= next else { throw Error.Reason.invalidNumber }
            case let value? where value.isTerminator:
                fallthrough
            case nil:
                return try constructNumber(significand: significand, mantisa: seenDecimal ? mantisa : nil, exponent: seenExponent ? exponent : nil, divisor: divisor, negative: negative, negativeExponent: negativeExponent)
            default:
                throw Error.Reason.invalidNumber
            }
        } while true
    }

    func constructNumber(significand: UInt64, mantisa: UInt64?, exponent: UInt64?, divisor: Double, negative: Bool, negativeExponent: Bool) throws -> JSON {
        if mantisa != nil || exponent != nil {
            var divisor = divisor
            divisor /= 10
            let number = Double(negative ? -1 : 1) * (Double(significand) + Double(mantisa ?? 0) / divisor)
            guard let exponent = exponent else { return .double(number) }
            return .double(Double(number) * pow(10, negativeExponent ? -Double(exponent) : Double(exponent)))
        } else {
            switch significand {
            case LegalCharacters.validUnsigned64BitInteger where !negative:
                return .integer(Int64(significand))
            case UInt64(Int64.max) + 1 where negative:
                return .integer(Int64.min)
            case LegalCharacters.validUnsigned64BitInteger where negative:
                return .integer(-Int64(significand))
            default:
                throw Error.Reason.numberOverflow
            }
        }
    }

    // TODO (vdka): refactor
    // TODO (vdka): option to _repair_ Unicode
    // NOTE(vdka): Not sure I ever will get to refactoring this, I just don't find Swift's String _comfortable_ to work with at a byte level.
    mutating func parseString() throws -> String {
        assert(peek() == LegalCharacters.quote)
        pop()
        var escaped = false
        stringBuffer.removeAll(keepingCapacity: true)
        repeat {
            guard let codeUnit = peek() else { throw Error.Reason.invalidEscape }
            pop()
            if codeUnit == LegalCharacters.backslash && !escaped {
                escaped = true
            } else if codeUnit == LegalCharacters.quote && !escaped {
                stringBuffer.append(0)
                return stringBuffer.withUnsafeBufferPointer { bufferPointer in
                    return String(cString: unsafeBitCast(bufferPointer.baseAddress, to: UnsafePointer<CChar>.self))
                }
            } else if escaped {
                switch codeUnit {
                case LegalCharacters.r:
                    stringBuffer.append(LegalCharacters.cr)
                case LegalCharacters.t:
                    stringBuffer.append(LegalCharacters.tab)
                case LegalCharacters.n:
                    stringBuffer.append(LegalCharacters.newline)
                case LegalCharacters.b:
                    stringBuffer.append(LegalCharacters.backspace)
                case LegalCharacters.f:
                    stringBuffer.append(LegalCharacters.formfeed)
                case LegalCharacters.quote:
                    stringBuffer.append(LegalCharacters.quote)
                case LegalCharacters.slash:
                    stringBuffer.append(LegalCharacters.slash)
                case LegalCharacters.backslash:
                    stringBuffer.append(LegalCharacters.backslash)
                case LegalCharacters.u:
                    let scalar = try parseUnicodeScalar()
                    UTF8.encode(scalar, into: { stringBuffer.append($0) })
                default:
                    throw Error.Reason.invalidEscape
                }
                escaped = false
            } else if LegalCharacters.invalidUnicodeBytes.contains(codeUnit) || codeUnit == 0xC0 || codeUnit == 0xC1 {
                throw Error.Reason.invalidUnicode
            } else {
                stringBuffer.append(codeUnit)
            }
        } while true
    }
}

extension JSON.Parser {
    mutating func parseUnicodeEscape() throws -> UTF16.CodeUnit {
        var codeUnit: UInt16 = 0
        for _ in 0..<4 {
            let c = pop()
            codeUnit <<= 4
            switch c {
            case LegalCharacters.numbers:
                codeUnit += UInt16(c - 48)
            case LegalCharacters.alphaNumericLower:
                codeUnit += UInt16(c - 87)
            case LegalCharacters.alphaNumericUpper:
                codeUnit += UInt16(c - 55)
            default:
                throw Error.Reason.invalidEscape
            }
        }

        return codeUnit
    }

    mutating func parseUnicodeScalar() throws -> UnicodeScalar {
        // For multi scalar Unicodes eg. flags
        var buffer: [UTF16.CodeUnit] = []

        let codeUnit = try parseUnicodeEscape()
        buffer.append(codeUnit)
        if UTF16.isLeadSurrogate(codeUnit) {
            guard pop() == LegalCharacters.backslash && pop() == LegalCharacters.u else { throw Error.Reason.invalidUnicode }
            let trailingSurrogate = try parseUnicodeEscape()
            guard UTF16.isTrailSurrogate(trailingSurrogate) else { throw Error.Reason.invalidUnicode }
            buffer.append(trailingSurrogate)
        }
        var gen = buffer.makeIterator()
        var utf = UTF16()
        switch utf.decode(&gen) {
        case .scalarValue(let scalar):
            return scalar
        case .emptyInput, .error:
            throw Error.Reason.invalidUnicode
        }
    }

    /// - Precondition: pointer will be on a comma character.
    mutating func skipComma() throws {
        assert(peek() == LegalCharacters.comma)
        pop()
        try skipWhitespace()
    }
}

extension JSON.Parser {
    public struct Error: Swift.Error, Equatable {
        public var byteOffset: Int
        public var reason: Reason

        public enum Reason: Swift.Error {
            case endOfStream
            case emptyStream
            case trailingComma
            case expectedComma
            case expectedColon
            case invalidEscape
            case invalidSyntax
            case invalidNumber
            case numberOverflow
            case invalidLiteral
            case invalidUnicode
            case fragmentedJson
            case unmatchedComment
        }

        public static func == (lhs: JSON.Parser.Error, rhs: JSON.Parser.Error) -> Bool {
            return lhs.byteOffset == rhs.byteOffset && lhs.reason == rhs.reason
        }
    }
}

// MARK: - Stdlib extensions
extension UnsafeBufferPointer {
    var endAddress: UnsafePointer<Element> {
        return baseAddress!.advanced(by: endIndex)
    }
}

extension UTF8.CodeUnit {
    var isWhitespace: Bool {
        if self == LegalCharacters.space || self == LegalCharacters.tab || self == LegalCharacters.cr || self == LegalCharacters.newline || self == LegalCharacters.formfeed {
            return true
        }
        return false
    }

    var isTerminator: Bool {
        if self.isWhitespace || self == LegalCharacters.comma || self == LegalCharacters.objectClose || self == LegalCharacters.arrayClose {
            return true
        }
        return false
    }
}
