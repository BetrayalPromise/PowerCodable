import Foundation

public typealias JSONNull = Null
public typealias JSONBool = Bool
public typealias JSONInteger = Int64
public typealias JSONDouble = Double
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

public protocol DateConvertible {}

extension JSON: DateConvertible {}
extension Array: DateConvertible where Element == JSON {}
extension Dictionary: DateConvertible where Key == String, Value == JSON {}

// MARK: - 解码key转化协议
public protocol DecodingKeyMappable {
    /// 可接受的keys
    static func modelDecodingKeys() -> [String: [String]]
}

extension DecodingKeyMappable {
    static func modelDecodingKeys() -> [String: [String]] {
        return ["": []]
    }
}

// MARK: - 解码value转化协议
public protocol DecodingValueMappable {
    // MARK: - Bool
    func toBool(path: JSONPath, value: JSON) throws -> Bool

    // MARK: - Int
    func toInt(path: JSONPath, value: JSON) throws -> Int

    // MARK: - Int8
    func toInt8(path: JSONPath, value: JSON) throws -> Int8

    // MARK: - Int16
    func toInt16(path: JSONPath, value: JSON) throws -> Int16

    // MARK: - Int32
    func toInt32(path: JSONPath, value: JSON) throws -> Int32

    // MARK: - Int64
    func toInt64(path: JSONPath, value: JSON) throws -> Int64

    // MARK: - UInt
    func toUInt(path: JSONPath, value: JSON) throws -> UInt

    // MARK: - UInt8
    func toUInt8(path: JSONPath, value: JSON) throws -> UInt8

    // MARK: - UInt16
    func toUInt16(path: JSONPath, value: JSON) throws -> UInt16

    // MARK: - UInt32
    func toUInt32(path: JSONPath, value: JSON) throws -> UInt32

    // MARK: - UInt64
    func toUInt64(path: JSONPath, value: JSON) throws -> UInt64

    // MARK: - Float
    func toFloat(path: JSONPath, value: JSON) throws -> Float

    // MARK: - Double
    func toDouble(path: JSONPath, value: JSON) throws -> Double

    // MARK: - String
    func toString(path: JSONPath, value: JSON) throws -> String

    // MARK: - Data
    func toData(path: JSONPath, value: JSON) throws -> Data

    // MARK: - Date
    func toDate(path: JSONPath, value: JSON) throws -> Date

    // MARK: - URL
    func toURL(path: JSONPath, value: JSON) throws -> URL
}

// MARK: - BOOL
extension DecodingValueMappable {
    func toBool(path: JSONPath, value: JSON) throws -> Bool {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxBool(json: value).bool
        case .bool(let bool): return bool
        case .string(let string): return Bool(string) ?? BoxBool(json: value).bool
        case .integer(let integer): return integer == 1 ? true : false
        case .double(_): return value == 1 ? true : false
        case .object(_): return BoxBool(json: value).bool
        case .array(_): return BoxBool(json: value).bool
        }
    }
}

// MARK: - INT
extension DecodingValueMappable {
    func toInt(path: JSONPath, value: JSON) throws -> Int {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxInt(json: value).int
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int(string) ?? BoxInt(json: value).int
        case .integer(let integer): return Int(integer)
        case .double(let double): return Int(double)
        case .object(_): return BoxInt(json: value).int
        case .array(_): return BoxInt(json: value).int
        }
    }
}

// MARK: - INT8
extension DecodingValueMappable {
    func toInt8(path: JSONPath, value: JSON) throws -> Int8 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxInt8(json: value).int8
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int8(string) ?? BoxInt8(json: value).int8
        case .integer(let integer): return Int8(integer)
        case .double(let double): return Int8(double)
        case .object(_): return BoxInt8(json: value).int8
        case .array(_): return BoxInt8(json: value).int8
        }
    }
}

// MARK: - INT16
extension DecodingValueMappable {
    func toInt16(path: JSONPath, value: JSON) throws -> Int16 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxInt16(json: value).int16
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int16(string) ?? BoxInt16(json: value).int16
        case .integer(let integer): return Int16(integer)
        case .double(let double): return Int16(double)
        case .object(_): return BoxInt16(json: value).int16
        case .array(_): return BoxInt16(json: value).int16
        }
    }
}

// MARK: - INT32
extension DecodingValueMappable {
    func toInt32(path: JSONPath, value: JSON) throws -> Int32 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxInt32(json: value).int32
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int32(string) ?? BoxInt32(json: value).int32
        case .integer(let integer): return Int32(integer)
        case .double(let double): return Int32(double)
        case .object(_): return BoxInt32(json: value).int32
        case .array(_): return BoxInt32(json: value).int32
        }
    }
}

// MARK: - INT64
extension DecodingValueMappable {
    func toInt64(path: JSONPath, value: JSON) throws -> Int64 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxInt64(json: value).int64
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int64(string) ?? BoxInt64(json: value).int64
        case .integer(let integer): return Int64(integer)
        case .double(let double): return Int64(double)
        case .object(_): return BoxInt64(json: value).int64
        case .array(_): return BoxInt64(json: value).int64
        }
    }
}

// MARK: - UINT
extension DecodingValueMappable {
    func toUInt(path: JSONPath, value: JSON) throws -> UInt {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxUInt(json: value).uint
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt(string) ?? BoxUInt(json: value).uint
        case .integer(let integer): return integer >= 0 ? UInt(integer) : BoxUInt(json: value).uint
        case .double(let double): return double >= 0 ? UInt(double) : BoxUInt(json: value).uint
        case .object(_): return BoxUInt(json: value).uint
        case .array(_): return BoxUInt(json: value).uint
        }
    }
}

// MARK: - UInt8
extension DecodingValueMappable {
    func toUInt8(path: JSONPath, value: JSON) throws -> UInt8 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxUInt8(json: value).uint8
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt8(string) ?? BoxUInt8(json: value).uint8
        case .integer(let integer): return integer >= 0 ? UInt8(integer) : BoxUInt8(json: value).uint8
        case .double(let double): return double >= 0 ? UInt8(double) : BoxUInt8(json: value).uint8
        case .object(_): return BoxUInt8(json: value).uint8
        case .array(_): return BoxUInt8(json: value).uint8
        }
    }
}

// MARK: - UInt16
extension DecodingValueMappable {
    func toUInt16(path: JSONPath, value: JSON) throws -> UInt16 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxUInt16(json: value).uint16
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt16(string) ?? BoxUInt16(json: value).uint16
        case .integer(let integer): return integer >= 0 ? UInt16(integer) : BoxUInt16(json: value).uint16
        case .double(let double): return double >= 0 ? UInt16(double) : BoxUInt16(json: value).uint16
        case .object(_): return BoxUInt16(json: value).uint16
        case .array(_): return BoxUInt16(json: value).uint16
        }
    }
}

// MARK: - UInt32
extension DecodingValueMappable {
    func toUInt32(path: JSONPath, value: JSON) throws -> UInt32 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxUInt32(json: value).uint32
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt32(string) ?? BoxUInt32(json: value).uint32
        case .integer(let integer): return integer >= 0 ? UInt32(integer) : BoxUInt32(json: value).uint32
        case .double(let double): return double >= 0 ? UInt32(double) : BoxUInt32(json: value).uint32
        case .object(_): return BoxUInt32(json: value).uint32
        case .array(_): return BoxUInt32(json: value).uint32
        }
    }
}

// MARK: - UInt64
extension DecodingValueMappable {
    func toUInt64(path: JSONPath, value: JSON) throws -> UInt64 {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxUInt64(json: value).uint64
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt64(string) ?? BoxUInt64(json: value).uint64
        case .integer(let integer): return integer >= 0 ? UInt64(integer) : BoxUInt64(json: value).uint64
        case .double(let double): return double >= 0 ? UInt64(double) : BoxUInt64(json: value).uint64
        case .object(_): return BoxUInt64(json: value).uint64
        case .array(_): return BoxUInt64(json: value).uint64
        }
    }
}

// MARK: - Float
extension DecodingValueMappable {
    func toFloat(path: JSONPath, value: JSON) throws -> Float {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxFloat(json: value).float
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Float(string) ?? BoxFloat(json: value).float
        case .integer(let integer): return Float(integer)
        case .double(let double): return Float(double)
        case .object(_): return BoxFloat(json: value).float
        case .array(_): return BoxFloat(json: value).float
        }
    }
}

// MARK: - Double
extension DecodingValueMappable {
    func toDouble(path: JSONPath, value: JSON) throws -> Double {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxDouble(json: value).double
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Double(string) ?? BoxDouble(json: value).double
        case .integer(let integer): return Double(integer)
        case .double(let double): return Double(double)
        case .object(_): return BoxDouble(json: value).double
        case .array(_): return BoxDouble(json: value).double
        }
    }
}

// MARK: - String
extension DecodingValueMappable {
    func toString(path: JSONPath, value: JSON) throws -> String {
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return "null"
        case .bool(let bool): return bool == true ? "true" : "false"
        case .string(let string): return string
        case .integer(let integer): return String(integer)
        case .double(let double): return String(double)
        case .object(_): return "[:]"
        case .array(_): return "[]"
        }
    }
}

// MARK: - Data
extension DecodingValueMappable {
    func toData(path: JSONPath, value: JSON) throws -> Data {
        guard let decoder: InnerDecoder = self as? InnerDecoder else { return BoxData(json: value).data }
        switch value {
        case .unknow: throw Coding.Exception.unknowJSON()
        case .null: return BoxData(json: value).data
        case .bool(_): return BoxData(json: value).data
        case .integer(let integer):
            switch decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
            case .base64:
                return integer.toData()?.base64EncodedData() ?? BoxData(json: value).data.base64EncodedData()
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: value)
                var value = value
                return Data(bytes: &value, count: size)
            case .useDefaultValues:
                return BoxData(json: value).data
            case .hexadecimalValues:
               return BoxData(json: value).data
            case .custom(let closure):
                do {
                    return try closure(decoder)
                } catch {
                    return BoxData(json: value).data
                }
            }
        case .double(let double):
            switch decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
            case .base64:
                return double.toData()?.base64EncodedData() ?? BoxData(json: value).data.base64EncodedData()
            case .useDefaultValues:
                return BoxData(json: value).data
            case .hexadecimalValues:
                return BoxData(json: value).data
            case .custom(let closure):
                do {
                    return try closure(decoder)
                } catch {
                    return BoxData(json: value).data
                }
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: value)
                var value = value
                return Data(bytes: &value, count: size)
            }
        case .string(let string):
            switch decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
            case .base64:
                return string.toData()?.base64EncodedData() ?? BoxData(json: value).data.base64EncodedData()
            case .useDefaultValues:
                return value.dataWrapper ?? Data()
            case .hexadecimalValues:
                return Data(hexString: string)
            case .custom(let closure):
                do {
                    return try closure(decoder)
                } catch {
                    return value.dataWrapper ?? Data()
                }
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: value)
                var value = value
                return Data(bytes: &value, count: size)
            }
        case .object(_): return BoxData(json: value).data
        case .array(_): return BoxData(json: value).data
        }
    }
}

// MARK: - URL
extension DecodingValueMappable {
    func toURL(path: JSONPath, value: JSON) throws -> URL {
        switch value {
        case .unknow: throw Coding.Exception.invalidTypeTransform()
        case .null: return BoxURL(json: value).url
        case .bool(_): return BoxURL(json: value).url
        case .integer(_): return BoxURL(json: value).url
        case .double(_): return BoxURL(json: value).url
        case .string(let string):
            do {
                return try URL.buildURL(string: string)
            } catch {
                return BoxURL(json: value).url
            }
        case .object(_): return BoxURL(json: value).url
        case .array(_): return BoxURL(json: value).url
        }
    }
}

// MARK: - Date
extension DecodingValueMappable {
    func toDate(path: JSONPath, value: JSON) throws -> Date {
        guard let decoder: InnerDecoder = self as? InnerDecoder else { return BoxDate(json: value).date }
        switch value {
        case .unknow: throw Coding.Exception.invalidTypeTransform()
        case .null: return BoxDate(json: value).date
        case .bool(_): return BoxDate(json: value).date
        case .integer(let integer):
            switch decoder.wrapper?.strategy.dateValueMapping ?? .secondsSince1970(json: .second) {
            case .custom(let closure):
                do {
                    return try closure(decoder, decoder.paths, value)
                } catch  {
                    return BoxDate(json: value).date
                }
            case .secondsSince1970(json: let form):
                switch form {
                case .second:
                    return Date(timeIntervalSince1970: TimeInterval(Double(integer)))
                case .millisecond:
                    return Date(timeIntervalSince1970: TimeInterval(Double(integer) / 1000.0))
                }
            case .millisecondsSince1970(json: let form):
                switch form {
                case .second:
                    return Date(timeIntervalSince1970: TimeInterval(Double(integer)))
                case .millisecond:
                    return Date(timeIntervalSince1970: TimeInterval(Double(integer) / 1000.0))
                }
            case .utc, .deferredToDate:
                let date = Date(timeIntervalSince1970: TimeInterval(integer))
                let dateformatter = DateFormatter.utc()
                return dateformatter.date(from: dateformatter.string(from: date)) ?? Date()
            case .iso8601:
                let date = Date(timeIntervalSince1970: TimeInterval(integer))
                let dateformatter = DateFormatter.iso8601()
                return dateformatter.date(from: dateformatter.string(from: date)) ?? Date()
            }
        case .double(let double):
            switch decoder.wrapper?.strategy.dateValueMapping ?? .secondsSince1970(json: .second) {
            case .custom(let closure):
                do {
                    return try closure(decoder, decoder.paths, value)
                } catch  {
                   return BoxDate(json: value).date
                }
            case .secondsSince1970(json: let form):
                switch form {
                case .second: return Date(timeIntervalSince1970: TimeInterval(Double(double)))
                case .millisecond: return Date(timeIntervalSince1970: TimeInterval(Double(double) / 1000.0))
                }
            case .millisecondsSince1970(json: let form):
                switch form {
                case .second: return Date(timeIntervalSince1970: TimeInterval(Double(double)))
                case .millisecond: return Date(timeIntervalSince1970: TimeInterval(Double(double) / 1000.0))
                }
            case .utc, .deferredToDate:
                let date = Date(timeIntervalSince1970: TimeInterval(double))
                let dateformatter = DateFormatter.utc()
                return dateformatter.date(from: dateformatter.string(from: date)) ?? Date()
            case .iso8601:
                let date = Date(timeIntervalSince1970: TimeInterval(double))
                let dateformatter = DateFormatter.iso8601()
                return dateformatter.date(from: dateformatter.string(from: date)) ?? Date()
            }
        case .string(let string):
            switch decoder.wrapper?.strategy.dateValueMapping ?? .secondsSince1970(json: .second) {
            case .custom(let closure):
                do {
                    return try closure(decoder, decoder.paths, value)
                } catch  {
                    return BoxDate(json: value).date
                }
            case .secondsSince1970(let form):
                guard let double = TimeInterval(string) else { return BoxDate(json: value).date }
                switch form {
                case .second:
                    return Date(timeIntervalSince1970: TimeInterval(double))
                case .millisecond:
                    return Date(timeIntervalSince1970: TimeInterval(double / 1000.0))
                }
            case .millisecondsSince1970(json: let form):
                guard let double = TimeInterval(string) else { return BoxDate(json: value).date }
                switch form {
                case .second: return Date(timeIntervalSince1970: TimeInterval(double))
                case .millisecond: return Date(timeIntervalSince1970: TimeInterval(double / 1000.0))
                }
            case .utc, .deferredToDate:
                let formatter = DateFormatter.utc()
                guard let date: Date = formatter.date(from: string) else { return BoxDate(json: value).date }
                return date
            case .iso8601:
                let formatter = DateFormatter.iso8601()
                guard let date: Date = formatter.date(from: string) else { return BoxDate(json: value).date }
                return date
            }
        case .object(_): return BoxDate(json: value).date
        case .array(_): return BoxDate(json: value).date
        }
    }
}

// MARK: - 编码key转化协议
public protocol EncodingKeyMappable {
    /// 可转变的keys
    /// /// 优先级是策略中最高的 如果制定了编码器的Key策略,同时也实现了该协议,最终是该协议生效而不是设置编码器Key的生效
    static func modelEncodingKeys() -> [String: String]
}

extension EncodingKeyMappable {
    static func modelEncodingKeys() -> [String: String] {
        return ["": ""]
    }
}

// MARK: - 编码value转化协议
public protocol EncodingValueMappable {
    func toJSON(path: JSONPath, value: JSONNull) -> JSON
    func toJSON(path: JSONPath, value: JSONBool) -> JSON
    func toJSON(path: JSONPath, value: JSONInteger) -> JSON
    func toJSON(path: JSONPath, value: JSONDouble) -> JSON
    func toJSON(path: JSONPath, value: JSONString) -> JSON
    func toJSON(path: JSONPath, value: JSONObject) -> JSON
    func toJSON(path: JSONPath, value: JSONArray) -> JSON
}

extension EncodingValueMappable {
    func toJSON(path: JSONPath, value: JSONNull) -> JSON {
        return JSON(nilLiteral: ())
    }

    func toJSON(path: JSONPath, value: JSONBool) -> JSON {
        return JSON(booleanLiteral: value)
    }

    func toJSON(path: JSONPath, value: JSONInteger) -> JSON {
        return JSON(integerLiteral: IntegerLiteralType(value))
    }

    func toJSON(path: JSONPath, value: JSONDouble) -> JSON {
        return JSON(floatLiteral: value)
    }

    func toJSON(path: JSONPath, value: JSONString) -> JSON {
        return JSON(stringLiteral: value)
    }

    func toJSON(path: JSONPath, value: JSONObject) -> JSON {
        return JSON(object: value)
    }

    func toJSON(path: JSONPath, value: JSONArray) -> JSON {
        return JSON(array: value)
    }
}

protocol JSONCodingSupport {
    /// JSON的二进制数据
    var dataWrapper: Data? { get }
    /// 关联类型
    associatedtype Wrapper
}

extension Data: JSONCodingSupport {
    typealias Wrapper = Data
    var dataWrapper: Data? {
        return self
    }
}

extension String: JSONCodingSupport {
    public typealias Wrapper = String
    public var dataWrapper: Data? {
        return self.data(using: Encoding.utf8)
    }
}

/// 对内存中的json结构对象进行描述 用它包裹真实的son
public struct JSONStructure: JSONCodingSupport {
    public typealias Wrapper = Any

    public var dataWrapper: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self.json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return nil
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
