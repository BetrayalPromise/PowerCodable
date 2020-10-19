import Foundation

public typealias JSONNull = NSNull
public typealias JSONBool = Bool
public typealias JSONInteger = Int64
public typealias JSONFloating = Double
public typealias JSONString = String // 包含String, URL处理
public typealias JSONArray = [JSON]
public typealias JSONObject = [String: JSON]
public typealias JSONPath = String
public typealias JSONTuples = (String, JSON)

extension Array where Element == JSONTuples {
    func toJSONObject() -> JSONObject {
        var dictionary: [String: JSON] = [:]
        for item in self {
            dictionary.updateValue(item.1, forKey: item.0)
        }
        return dictionary
    }
}

extension Dictionary where Key == String, Value == JSON {
    func toJSONTuples() -> [JSONTuples] {
        var tuples: [JSONTuples] = []
        for (k, v) in self {
            tuples.append((k, v))
        }
        return tuples
    }
}

/// 基础类型转换处理
public protocol TypeConvertible {
    // MARK: Bool
    func toBool(path: JSONPath, value: JSONNull) -> Bool
    func toBool(path: JSONPath, value: JSONBool) -> Bool
    func toBool(path: JSONPath, value: JSONInteger) -> Bool
    func toBool(path: JSONPath, value: JSONFloating) -> Bool
    func toBool(path: JSONPath, value: JSONString) -> Bool
    func toBool(path: JSONPath, value: JSONObject) -> Bool
    func toBool(path: JSONPath, value: JSONArray) -> Bool

    // MARK: - Int
    func toInt(path: JSONPath, value: JSONNull) -> Int
    func toInt(path: JSONPath, value: JSONBool) -> Int
    func toInt(path: JSONPath, value: JSONInteger) -> Int
    func toInt(path: JSONPath, value: JSONFloating) -> Int
    func toInt(path: JSONPath, value: JSONString) -> Int
    func toInt(path: JSONPath, value: JSONObject) -> Int
    func toInt(path: JSONPath, value: JSONArray) -> Int

    // MARK:  - Int8
    func toInt8(path: JSONPath, value: JSONNull) -> Int8
    func toInt8(path: JSONPath, value: JSONBool) -> Int8
    func toInt8(path: JSONPath, value: JSONInteger) -> Int8
    func toInt8(path: JSONPath, value: JSONFloating) -> Int8
    func toInt8(path: JSONPath, value: JSONString) -> Int8
    func toInt8(path: JSONPath, value: JSONObject) -> Int8
    func toInt8(path: JSONPath, value: JSONArray) -> Int8

    // MARK: - Int16
    func toInt16(path: JSONPath, value: JSONNull) -> Int16
    func toInt16(path: JSONPath, value: JSONBool) -> Int16
    func toInt16(path: JSONPath, value: JSONInteger) -> Int16
    func toInt16(path: JSONPath, value: JSONFloating) -> Int16
    func toInt16(path: JSONPath, value: JSONString) -> Int16
    func toInt16(path: JSONPath, value: JSONObject) -> Int16
    func toInt16(path: JSONPath, value: JSONArray) -> Int16

    // MARK: - Int32
    func toInt32(path: JSONPath, value: JSONNull) -> Int32
    func toInt32(path: JSONPath, value: JSONBool) -> Int32
    func toInt32(path: JSONPath, value: JSONInteger) -> Int32
    func toInt32(path: JSONPath, value: JSONFloating) -> Int32
    func toInt32(path: JSONPath, value: JSONString) -> Int32
    func toInt32(path: JSONPath, value: JSONObject) -> Int32
    func toInt32(path: JSONPath, value: JSONArray) -> Int32

    // MARK: - Int64
    func toInt64(path: JSONPath, value: JSONNull) -> Int64
    func toInt64(path: JSONPath, value: JSONBool) -> Int64
    func toInt64(path: JSONPath, value: JSONInteger) -> Int64
    func toInt64(path: JSONPath, value: JSONFloating) -> Int64
    func toInt64(path: JSONPath, value: JSONString) -> Int64
    func toInt64(path: JSONPath, value: JSONObject) -> Int64
    func toInt64(path: JSONPath, value: JSONArray) -> Int64

    // MARK: - UInt
    func toUInt(path: JSONPath, value: JSONNull) -> UInt
    func toUInt(path: JSONPath, value: JSONBool) -> UInt
    func toUInt(path: JSONPath, value: JSONInteger) -> UInt
    func toUInt(path: JSONPath, value: JSONFloating) -> UInt
    func toUInt(path: JSONPath, value: JSONString) -> UInt
    func toUInt(path: JSONPath, value: JSONObject) -> UInt
    func toUInt(path: JSONPath, value: JSONArray) -> UInt

    // MARK: - UInt8
    func toUInt8(path: JSONPath, value: JSONNull) -> UInt8
    func toUInt8(path: JSONPath, value: JSONBool) -> UInt8
    func toUInt8(path: JSONPath, value: JSONInteger) -> UInt8
    func toUInt8(path: JSONPath, value: JSONFloating) -> UInt8
    func toUInt8(path: JSONPath, value: JSONString) -> UInt8
    func toUInt8(path: JSONPath, value: JSONObject) -> UInt8
    func toUInt8(path: JSONPath, value: JSONArray) -> UInt8

    // MARK: - UInt16
    func toUInt16(path: JSONPath, value: JSONNull) -> UInt16
    func toUInt16(path: JSONPath, value: JSONBool) -> UInt16
    func toUInt16(path: JSONPath, value: JSONInteger) -> UInt16
    func toUInt16(path: JSONPath, value: JSONFloating) -> UInt16
    func toUInt16(path: JSONPath, value: JSONString) -> UInt16
    func toUInt16(path: JSONPath, value: JSONObject) -> UInt16
    func toUInt16(path: JSONPath, value: JSONArray) -> UInt16

    // MARK: - UInt32
    func toUInt32(path: JSONPath, value: JSONNull) -> UInt32
    func toUInt32(path: JSONPath, value: JSONBool) -> UInt32
    func toUInt32(path: JSONPath, value: JSONInteger) -> UInt32
    func toUInt32(path: JSONPath, value: JSONFloating) -> UInt32
    func toUInt32(path: JSONPath, value: JSONString) -> UInt32
    func toUInt32(path: JSONPath, value: JSONObject) -> UInt32
    func toUInt32(path: JSONPath, value: JSONArray) -> UInt32

    // MARK: - UInt64
    func toUInt64(path: JSONPath, value: JSONNull) -> UInt64
    func toUInt64(path: JSONPath, value: JSONBool) -> UInt64
    func toUInt64(path: JSONPath, value: JSONInteger) -> UInt64
    func toUInt64(path: JSONPath, value: JSONFloating) -> UInt64
    func toUInt64(path: JSONPath, value: JSONString) -> UInt64
    func toUInt64(path: JSONPath, value: JSONObject) -> UInt64
    func toUInt64(path: JSONPath, value: JSONArray) -> UInt64

    // MARK: - Float
    func toFloat(path: JSONPath, value: JSONNull) -> Float
    func toFloat(path: JSONPath, value: JSONBool) -> Float
    func toFloat(path: JSONPath, value: JSONInteger) -> Float
    func toFloat(path: JSONPath, value: JSONFloating) -> Float
    func toFloat(path: JSONPath, value: JSONString) -> Float
    func toFloat(path: JSONPath, value: JSONObject) -> Float
    func toFloat(path: JSONPath, value: JSONArray) -> Float

    // MARK: - Double
    func toDouble(path: JSONPath, value: JSONNull) ->  Double
    func toDouble(path: JSONPath, value: JSONBool) -> Double
    func toDouble(path: JSONPath, value: JSONInteger) -> Double
    func toDouble(path: JSONPath, value: JSONFloating) -> Double
    func toDouble(path: JSONPath, value: JSONString) -> Double
    func toDouble(path: JSONPath, value: JSONObject) ->  Double
    func toDouble(path: JSONPath, value: JSONArray) ->  Double

    // MARK: - String
    func toString(path: JSONPath, value: JSONNull) -> String
    func toString(path: JSONPath, value: JSONBool) -> String
    func toString(path: JSONPath, value: JSONInteger) -> String
    func toString(path: JSONPath, value: JSONFloating) -> String
    func toString(path: JSONPath, value: JSONString) -> String
    func toString(path: JSONPath, value: JSONObject) -> String
    func toString(path: JSONPath, value: JSONArray) -> String
}

// MARK: - BOOL -
extension TypeConvertible {
    func toBool(path: JSONPath, value: JSONNull) -> Bool { return false }
    func toBool(path: JSONPath, value: JSONBool) -> Bool { return value }
    func toBool(path: JSONPath, value: JSONInteger) -> Bool { return value == 1 ? true : false }
    func toBool(path: JSONPath, value: JSONFloating) -> Bool { return value == 1 ? true : false }
    func toBool(path: JSONPath, value: JSONString) -> Bool { return Bool(value) ?? false }
    func toBool(path: JSONPath, value: JSONObject) -> Bool { return false }
    func toBool(path: JSONPath, value: JSONArray) -> Bool { return false }
}

// MARK: - INT -
extension TypeConvertible {
    func toInt(path: JSONPath, value: JSONNull) -> Int { return 0 }
    func toInt(path: JSONPath, value: JSONBool) -> Int { return value == true ? 1 : 0 }
    func toInt(path: JSONPath, value: JSONInteger) -> Int { return Int(value) }
    func toInt(path: JSONPath, value: JSONFloating) -> Int { return Int(value) }
    func toInt(path: JSONPath, value: JSONString) -> Int { return Int(value) ?? 0 }
    func toInt(path: JSONPath, value: JSONObject) -> Int { return 0 }
    func toInt(path: JSONPath, value: JSONArray) -> Int { return 0 }
}

// MARK: - INT8 -
extension TypeConvertible {
    func toInt8(path: JSONPath, value: JSONNull) -> Int8 { return 0 }
    func toInt8(path: JSONPath, value: JSONBool) -> Int8 { return value == true ? 1 : 0 }
    func toInt8(path: JSONPath, value: JSONInteger) -> Int8 { return Int8(value) }
    func toInt8(path: JSONPath, value: JSONFloating) -> Int8 { return Int8(value) }
    func toInt8(path: JSONPath, value: JSONString) -> Int8 { return Int8(value) ?? 0 }
    func toInt8(path: JSONPath, value: JSONObject) -> Int8 { return 0 }
    func toInt8(path: JSONPath, value: JSONArray) -> Int8 { return 0 }
}

// MARK: - INT16 -
extension TypeConvertible {
    func toInt16(path: JSONPath, value: JSONNull) -> Int16 { return 0 }
    func toInt16(path: JSONPath, value: JSONBool) -> Int16 { return value == true ? 1 : 0 }
    func toInt16(path: JSONPath, value: JSONInteger) -> Int16 { return Int16(value) }
    func toInt16(path: JSONPath, value: JSONFloating) -> Int16 { return Int16(value) }
    func toInt16(path: JSONPath, value: JSONString) -> Int16 { return Int16(value) ?? 0 }
    func toInt16(path: JSONPath, value: JSONObject) -> Int16 { return 0 }
    func toInt16(path: JSONPath, value: JSONArray) -> Int16 { return 0 }
}

// MARK: - INT32 -
extension TypeConvertible {
    func toInt32(path: JSONPath, value: JSONNull) -> Int32 { return 0 }
    func toInt32(path: JSONPath, value: JSONBool) -> Int32 { return value == true ? 1 : 0 }
    func toInt32(path: JSONPath, value: JSONInteger) -> Int32 { return Int32(value) }
    func toInt32(path: JSONPath, value: JSONFloating) -> Int32 { return Int32(value) }
    func toInt32(path: JSONPath, value: JSONString) -> Int32 { return Int32(value) ?? 0 }
    func toInt32(path: JSONPath, value: JSONObject) -> Int32 { return 0 }
    func toInt32(path: JSONPath, value: JSONArray) -> Int32 { return 0 }
}

// MARK: - INT64 -
extension TypeConvertible {
    func toInt64(path: JSONPath, value: JSONNull) -> Int64 { return 0 }
    func toInt64(path: JSONPath, value: JSONBool) -> Int64 { return value == true ? 1 : 0 }
    func toInt64(path: JSONPath, value: JSONInteger) -> Int64 { return Int64(value) }
    func toInt64(path: JSONPath, value: JSONFloating) -> Int64  { return Int64(value) }
    func toInt64(path: JSONPath, value: JSONString) -> Int64  { return Int64(value) ?? 0 }
    func toInt64(path: JSONPath, value: JSONObject) -> Int64  { return 0 }
    func toInt64(path: JSONPath, value: JSONArray) -> Int64  { return 0 }
}

// MARK: - UINT -
extension TypeConvertible {
    func toUInt(path: JSONPath, value: JSONNull) -> UInt { return 0 }
    func toUInt(path: JSONPath, value: JSONBool) -> UInt { return value == true ? 1 : 0 }
    func toUInt(path: JSONPath, value: JSONInteger) -> UInt { return value >= 0 ? UInt(value) : 0 }
    func toUInt(path: JSONPath, value: JSONFloating) -> UInt { return value >= 0 ? UInt(value) : 0 }
    func toUInt(path: JSONPath, value: JSONString) -> UInt { return UInt(value) ?? 0 }
    func toUInt(path: JSONPath, value: JSONObject) -> UInt { return 0 }
    func toUInt(path: JSONPath, value: JSONArray) -> UInt { return 0 }
}

// MARK: - UInt8 -
extension TypeConvertible {
    func toUInt8(path: JSONPath, value: JSONNull) -> UInt8 { return 0 }
    func toUInt8(path: JSONPath, value: JSONBool) -> UInt8 { return value == true ? 1 : 0 }
    func toUInt8(path: JSONPath, value: JSONInteger) -> UInt8 { return value >= 0 ? UInt8(value) : 0 }
    func toUInt8(path: JSONPath, value: JSONFloating) -> UInt8 { return value >= 0 ? UInt8(value) : 0 }
    func toUInt8(path: JSONPath, value: JSONString) -> UInt8 { return UInt8(value) ?? 0 }
    func toUInt8(path: JSONPath, value: JSONObject) -> UInt8 { return 0 }
    func toUInt8(path: JSONPath, value: JSONArray) -> UInt8 { return 0 }
}

// MARK: - UInt16 -
extension TypeConvertible {
    func toUInt16(path: JSONPath, value: JSONNull) -> UInt16 { return 0 }
    func toUInt16(path: JSONPath, value: JSONBool) -> UInt16 { return value == true ? 1 : 0 }
    func toUInt16(path: JSONPath, value: JSONInteger) -> UInt16  { return value >= 0 ? UInt16(value) : 0 }
    func toUInt16(path: JSONPath, value: JSONFloating) -> UInt16  { return value >= 0 ? UInt16(value) : 0 }
    func toUInt16(path: JSONPath, value: JSONString) -> UInt16 { return UInt16(value) ?? 0 }
    func toUInt16(path: JSONPath, value: JSONObject) -> UInt16 { return 0 }
    func toUInt16(path: JSONPath, value: JSONArray) -> UInt16 { return 0 }
}

// MARK: - UInt32 -
extension TypeConvertible {
    func toUInt32(path: JSONPath, value: JSONNull) -> UInt32 { return 0 }
    func toUInt32(path: JSONPath, value: JSONBool) -> UInt32 { return value == true ? 1 : 0 }
    func toUInt32(path: JSONPath, value: JSONInteger) -> UInt32 { return value >= 0 ? UInt32(value) : 0 }
    func toUInt32(path: JSONPath, value: JSONFloating) -> UInt32 { return value >= 0 ? UInt32(value) : 0 }
    func toUInt32(path: JSONPath, value: JSONString) -> UInt32 { return UInt32(value) ?? 0 }
    func toUInt32(path: JSONPath, value: JSONObject) -> UInt32 { return 0 }
    func toUInt32(path: JSONPath, value: JSONArray) -> UInt32 { return 0 }
}

// MARK: - UInt64 -
extension TypeConvertible {
    func toUInt64(path: JSONPath, value: JSONNull) -> UInt64 { return 0 }
    func toUInt64(path: JSONPath, value: JSONBool) -> UInt64 { return value == true ? 1 : 0 }
    func toUInt64(path: JSONPath, value: JSONInteger) -> UInt64 { return value >= 0 ? UInt64(value) : 0 }
    func toUInt64(path: JSONPath, value: JSONFloating) -> UInt64 { return value >= 0 ? UInt64(value) : 0 }
    func toUInt64(path: JSONPath, value: JSONString) -> UInt64 { return UInt64(value) ?? 0 }
    func toUInt64(path: JSONPath, value: JSONObject) -> UInt64 { return 0 }
    func toUInt64(path: JSONPath, value: JSONArray) -> UInt64  { return 0 }
}

// MARK: - Float -
extension TypeConvertible {
    func toFloat(path: JSONPath, value: JSONNull) -> Float { return 0 }
    func toFloat(path: JSONPath, value: JSONBool) -> Float { return value == true ? 1 : 0 }
    func toFloat(path: JSONPath, value: JSONInteger) -> Float { return Float(value) }
    func toFloat(path: JSONPath, value: JSONFloating) -> Float { return Float(value) }
    func toFloat(path: JSONPath, value: JSONString) -> Float { return Float(value) ?? 0 }
    func toFloat(path: JSONPath, value: JSONObject) -> Float  { return 0 }
    func toFloat(path: JSONPath, value: JSONArray) -> Float { return 0 }
}

// MARK: - Double -
extension TypeConvertible {
    func toDouble(path: JSONPath, value: JSONNull) ->  Double { return 0 }
    func toDouble(path: JSONPath, value: JSONBool) -> Double { return value == true ? 1 : 0 }
    func toDouble(path: JSONPath, value: JSONInteger) -> Double { return Double(value) }
    func toDouble(path: JSONPath, value: JSONFloating) -> Double { return Double(value) }
    func toDouble(path: JSONPath, value: JSONString) -> Double  { return Double(value) ?? 0 }
    func toDouble(path: JSONPath, value: JSONObject) ->  Double { return 0 }
    func toDouble(path: JSONPath, value: JSONArray) ->  Double { return 0 }
}

// MARK: - String -
extension TypeConvertible {
    func toString(path: JSONPath, value: JSONNull) -> String { return "null" }
    func toString(path: JSONPath, value: JSONBool) -> String { return value == true ? "true" : "false" }
    func toString(path: JSONPath, value: JSONInteger) -> String { return String(value) }
    func toString(path: JSONPath, value: JSONFloating) -> String { return String(value) }
    func toString(path: JSONPath, value: JSONString) -> String  { return value }
    func toString(path: JSONPath, value: JSONObject) -> String { return "[:]" }
    func toString(path: JSONPath, value: JSONArray) -> String { return "[]" }
}

public protocol MappingDecodingKeys {
    /// 可接受的keys
    static func modelDecodingKeys() -> [String: [String]]
}

extension MappingDecodingKeys {
    static func modelDecodingKeys() -> [String: [String]] {
        return ["": []]
    }
}

public protocol MappingEncodingKeysValues {
    /// 可转变的keys
    static func modelEncodingKeys() -> [String: String]
    static func modelEncodingValues(path: JSONPath, value: JSON) -> JSON
}

extension MappingEncodingKeysValues {
    static func modelEncodingKeys() -> [String: String] {
        return ["": ""]
    }
    static func modelEncodingValues(path: JSONPath, value: JSON) -> JSON {
        return JSON.defaultJSON()
    }
}

protocol JSONCodingSupport {
    /// JSON的二进制数据
    var dataWrapper: Data { get }

    associatedtype Wrapper
}

extension Data: JSONCodingSupport {
    typealias Wrapper = Data
    var dataWrapper: Data {
        return self
    }
}

extension String: JSONCodingSupport {
    public typealias Wrapper = String
    public var dataWrapper: Data {
        return self.data(using: Encoding.utf8) ?? Data()
    }
}

/// 对内存中的json结构对象进行描述 用它指代json
public struct JSONStructure: JSONCodingSupport {
    public typealias Wrapper = Any

    public var dataWrapper: Data {
        do {
            return try JSONSerialization.data(withJSONObject: self.json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return Data()
        }
    }
    /// JSON实体
    let json: Any
    let topLevelType: RootNodeType

    init(json: Any) {
        self.json = json
        if ((json as? Array<Any>) != nil) {
            self.topLevelType = .array
        } else if ((json as? Dictionary<AnyHashable, Any>) != nil) {
            self.topLevelType = .dictionary
        } else {
            self.topLevelType = .none
        }
    }

    public enum RootNodeType {
        case none
        case array
        case dictionary
    }
}
