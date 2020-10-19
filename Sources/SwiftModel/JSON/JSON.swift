import Foundation

/// MARK: JSON抽象 由于Swift中的JSON解析器给出的是Any类型 无法明确需要强转后再处理, 本工具使用JSON结构体明确可以看出JSON结构
@dynamicMemberLookup
public enum JSON: JSONCodingSupport {
    typealias Wrapper = JSON
    indirect case object([String: JSON])
    indirect case array([JSON])
    case null
    case bool(Bool)
    case string(String)
    case integer(Int64)
    case double(Double)
    case unknow // 给定一个unknow的初始值区别与null, 任何使用unknow的处理都会抛出异常

    /// @dynamicMemberLookup
    subscript(dynamicMember member: String) -> JSON {
        return (try? self.get(member)) ?? .null
    }

    var dataWrapper: Data {
        do {
            let string: String = try JSON.Serializer.serialize(self)
            return string.data(using: String.Encoding.utf8) ?? Data()
        } catch  {
            print(error.localizedDescription)
            return Data()
        }
    }
}

extension JSON {
    static func defaultJSON() -> JSON {
        return JSON(stringLiteral: "2020/10/10-15:16:30")
    }
}

public extension JSON {
    static var level: Int = 0
    func path() {
        JSON.level += 1
        defer {
            JSON.level -= 1
        }
        switch self {
        case .array(let array):
            for (i, item) in array.enumerated() {
                print("level: \(JSON.level) ---- []\(i)")
                item.path()
            }
        case .object(let object):
            for (key, _) in object {
                print("level: \(JSON.level) ---- [:]\(key)")
                object[key]?.path()
            }
        case .bool(let bool):
            print("result: ---- bool: \(bool)")
        case .integer(let integer):
            print("result: ---- integer: \(integer)")
        case .double(let doulbe):
            print("result: ---- integer: \(doulbe)")
        case .string(let string):
            print("result: ---- string: \(string)")
        case .null:
            print("result: ---- null")
        case .unknow:
            print("unknow or default, error")
        }
    }
}

// MARK: - JSON Equatable协议
extension JSON: Equatable {
    static public func ==(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.object(let l), .object(let r)): return l == r
        case (.array(let l), .array(let r)): return l == r
        case (.null, .null): return true
        case (.bool(let l), .bool(let r)): return l == r
        case (.string(let l), .string(let r)): return l == r
        case (.double(let l), .double(let r)): return l == r
        case (.integer(let l), .integer(let r)): return l == r
        default: return false
        }
    }
}

// MARK: - ExpressibleBy
extension JSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSONRepresentable...) {
        let array = elements.map({ $0.encoded() })
        self = .array(array)
    }

    init(emptyArray: [Any] = []) {
        self = .array([])
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSONRepresentable)...) {
        var dict: [String: JSON] = [:]
        for (key, value) in elements {
            dict[key] = value.encoded()
        }
        self = .object(dict)
    }

    init(emptyDictionary: [String: Any]) {
        self = .object([:])
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        let val = Int64(value)
        self = .integer(val)
    }
}

extension JSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        let val = Double(value)
        self = .double(val)
    }
}

extension JSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self = .string(value)
    }
}

extension JSON: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .null
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}


// MARK: - JSON: CustomStringConvertible
extension JSON {
    /**
     Turns a nested graph of `JSON`s into a Swift `String`. This produces JSON data that
     strictly conforms to [RFT7159](https://tools.ietf.org/html/rfc7159).
     It can optionally pretty-print the output for debugging, but this comes with a non-negligible performance cost.
     */
    public func serialized(options: JSON.Serializer.Option = []) throws -> String {
        return try JSON.Serializer.serialize(self, options: options)
    }
}

extension JSON: CustomStringConvertible {
    public var description: String {
        do {
            return try self.serialized()
        } catch {
            return String(describing: error)
        }
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        do {
            return try self.serialized(options: .prettyPrint)
        } catch {
            return String(describing: error)
        }
    }
}

extension JSON: Sequence {
    public func makeIterator() -> AnyIterator<JSON> {
        switch self {
        case .array(let array):
            var iterator = array.makeIterator()
            return AnyIterator {
                return iterator.next()
            }
        case .object(let object):
            var iterator = object.makeIterator()
            return AnyIterator {
                guard let (key, value) = iterator.next() else { return nil }
                return .object([key: value])
            }
        default:
            var value: JSON? = self
            return AnyIterator {
                defer { value = nil }
                if case .null? = value { return nil }
                return value
            }
        }
    }
}

// MARK: - JSON error
extension JSON {
    /// Represent an error resulting during mapping either, to or from an instance type.
    public enum Error: Swift.Error {
        // BadField indicates an error where a field was missing or was of the wrong type. The associated value represents the name of the field.
        case badField(String)
        /// When thrown during initialization it indicates a value in the JSON could not be converted to RFC
        case badValue(JSON)
        /// A number was not valid per the JSON spec. (handled in Parser?)
        case invalidNumber
    }
}
