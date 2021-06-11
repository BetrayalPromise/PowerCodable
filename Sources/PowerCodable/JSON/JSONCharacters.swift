import Foundation

struct LegalCharacters {
    // json special characters
    static let arrayOpen: UTF8.CodeUnit = "[".utf8.first!
    static let objectOpen: UTF8.CodeUnit = "{".utf8.first!
    static let arrayClose: UTF8.CodeUnit = "]".utf8.first!
    static let objectClose: UTF8.CodeUnit = "}".utf8.first!
    static let comma: UTF8.CodeUnit = ",".utf8.first!
    static let colon: UTF8.CodeUnit = ":".utf8.first!
    static let quote: UTF8.CodeUnit = "\"".utf8.first!
    static let slash: UTF8.CodeUnit = "/".utf8.first!
    static let backslash: UTF8.CodeUnit = "\\".utf8.first!

    static let star: UTF8.CodeUnit = "*".utf8.first!

    // whitespace characters
    static let space: UTF8.CodeUnit = " ".utf8.first!
    static let tab: UTF8.CodeUnit = "\t".utf8.first!
    static let cr: UTF8.CodeUnit = "\r".utf8.first!
    static let newline: UTF8.CodeUnit = "\n".utf8.first!
    static let backspace: UTF8.CodeUnit = UTF8.CodeUnit(0x08)
    static let formfeed: UTF8.CodeUnit = UTF8.CodeUnit(0x0C)

    // Literal characters
    static let n: UTF8.CodeUnit = "n".utf8.first!
    static let t: UTF8.CodeUnit = "t".utf8.first!
    static let r: UTF8.CodeUnit = "r".utf8.first!
    static let u: UTF8.CodeUnit = "u".utf8.first!
    static let f: UTF8.CodeUnit = "f".utf8.first!
    static let a: UTF8.CodeUnit = "a".utf8.first!
    static let l: UTF8.CodeUnit = "l".utf8.first!
    static let s: UTF8.CodeUnit = "s".utf8.first!
    static let e: UTF8.CodeUnit = "e".utf8.first!

    static let b: UTF8.CodeUnit = "b".utf8.first!

    // Number characters
    static let E: UTF8.CodeUnit = "E".utf8.first!
    static let zero: UTF8.CodeUnit = "0".utf8.first!
    static let plus: UTF8.CodeUnit = "+".utf8.first!
    static let minus: UTF8.CodeUnit = "-".utf8.first!
    static let decimal: UTF8.CodeUnit = ".".utf8.first!
    static let numbers: ClosedRange<UTF8.CodeUnit> = "0".utf8.first!..."9".utf8.first!
    static let alphaNumericLower: ClosedRange<UTF8.CodeUnit> = "a".utf8.first!..."f".utf8.first!
    static let alphaNumericUpper: ClosedRange<UTF8.CodeUnit> = "A".utf8.first!..."F".utf8.first!

    static let invalidUnicodeBytes: ClosedRange<UTF8.CodeUnit> = 0xF5...0xFF

    // Valid integer number Range
    static let valid64BitInteger: ClosedRange<Int64> = Int64.min...Int64.max
    static let validUnsigned64BitInteger: ClosedRange<UInt64> = UInt64.min...UInt64(Int64.max)

    // End of here Literals
    static let rue: [UTF8.CodeUnit] = ["r".utf8.first!, "u".utf8.first!, "e".utf8.first!]
    static let alse: [UTF8.CodeUnit] = ["a".utf8.first!, "l".utf8.first!, "s".utf8.first!, "e".utf8.first!]
    static let ull: [UTF8.CodeUnit] = ["u".utf8.first!, "l".utf8.first!, "l".utf8.first!]

    // Comment stuff
    static let lineComment: [UTF8.CodeUnit] = ["/".utf8.first!, "/".utf8.first!]
    static let blockCommentStart: [UTF8.CodeUnit] = ["/".utf8.first!, "*".utf8.first!]
    static let blockCommentEnd: [UTF8.CodeUnit] = ["*".utf8.first!, "/".utf8.first!]
}

//// json special characters
//static let arrayOpen: UTF8.CodeUnit = "[".utf8.first!
//static let objectOpen: UTF8.CodeUnit = "{".utf8.first!
//static let arrayClose: UTF8.CodeUnit = "]".utf8.first!
//static let objectClose: UTF8.CodeUnit = "}".utf8.first!
//static let comma: UTF8.CodeUnit = ",".utf8.first!
//static let colon: UTF8.CodeUnit = ":".utf8.first!
//static let quote: UTF8.CodeUnit = "\"".utf8.first!
//static let slash: UTF8.CodeUnit = "/".utf8.first!
//static let backslash: UTF8.CodeUnit = "\\".utf8.first!
//
//static let star: UTF8.CodeUnit = "*".utf8.first!
//
//// whitespace characters
//static let space: UTF8.CodeUnit = " ".utf8.first!
//static let tab: UTF8.CodeUnit = "\t".utf8.first!
//static let cr: UTF8.CodeUnit = "\r".utf8.first!
//static let newline: UTF8.CodeUnit = "\n".utf8.first!
//static let backspace: UTF8.CodeUnit = UTF8.CodeUnit(0x08)
//static let formfeed: UTF8.CodeUnit = UTF8.CodeUnit(0x0C)
//
//// Literal characters
//static let n: UTF8.CodeUnit = "n".utf8.first!
//static let t: UTF8.CodeUnit = "t".utf8.first!
//static let r: UTF8.CodeUnit = "r".utf8.first!
//static let u: UTF8.CodeUnit = "u".utf8.first!
//static let f: UTF8.CodeUnit = "f".utf8.first!
//static let a: UTF8.CodeUnit = "a".utf8.first!
//static let l: UTF8.CodeUnit = "l".utf8.first!
//static let s: UTF8.CodeUnit = "s".utf8.first!
//static let e: UTF8.CodeUnit = "e".utf8.first!
//
//static let b: UTF8.CodeUnit = "b".utf8.first!
//
//// Number characters
//static let E: UTF8.CodeUnit = "E".utf8.first!
//static let zero: UTF8.CodeUnit = "0".utf8.first!
//static let plus: UTF8.CodeUnit = "+".utf8.first!
//static let minus: UTF8.CodeUnit = "-".utf8.first!
//static let decimal: UTF8.CodeUnit = ".".utf8.first!
//static let numbers: ClosedRange<UTF8.CodeUnit> = "0".utf8.first!..."9".utf8.first!
//static let alphaNumericLower: ClosedRange<UTF8.CodeUnit> = "a".utf8.first!..."f".utf8.first!
//static let alphaNumericUpper: ClosedRange<UTF8.CodeUnit> = "A".utf8.first!..."F".utf8.first!
//
//static let invalidUnicodeBytes: ClosedRange<UTF8.CodeUnit> = 0xF5...0xFF
//
//// Valid integer number Range
//static let valid64BitInteger: ClosedRange<Int64> = Int64.min...Int64.max
//static let validUnsigned64BitInteger: ClosedRange<UInt64> = UInt64.min...UInt64(Int64.max)
//
//// End of here Literals
//static let rue: [UTF8.CodeUnit] = ["r".utf8.first!, "u".utf8.first!, "e".utf8.first!]
//static let alse: [UTF8.CodeUnit] = ["a".utf8.first!, "l".utf8.first!, "s".utf8.first!, "e".utf8.first!]
//static let ull: [UTF8.CodeUnit] = ["u".utf8.first!, "l".utf8.first!, "l".utf8.first!]
//
//// Comment stuff
//static let lineComment: [UTF8.CodeUnit] = ["/".utf8.first!, "/".utf8.first!]
//static let blockCommentStart: [UTF8.CodeUnit] = ["/".utf8.first!, "*".utf8.first!]
//static let blockCommentEnd: [UTF8.CodeUnit] = ["*".utf8.first!, "/".utf8.first!]
