import Foundation

public typealias PowerNull = BoxNull
public typealias PowerBool = Bool
public typealias PowerInteger = Int64
public typealias PowerDouble = Double
public typealias PowerString = String // 包含String, URL处理
public typealias PowerArray = [JSON]
public typealias PowerObject = [String: JSON]
public typealias PowerTuples = (String, JSON)

extension Array where Element == PowerTuples {
    func toPowerObject() -> PowerObject {
        var dictionary: [String: JSON] = [:]
        for item in self {
            dictionary.updateValue(item.1, forKey: item.0)
        }
        return dictionary
    }
}

extension Dictionary where Key == String, Value == JSON {
    func toPowerTuples() -> [PowerTuples] {
        var tuples: [PowerTuples] = []
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
public protocol DecodeKeyMappable {
    /// json转化为model时候,model可以接受的json字段集合,并且不受到编码策略keyFormatStrategy的影响
    /// - Parameters:
    ///   - decoder: 解码器
    ///   - paths: 编码路径集合
    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]]
}

extension DecodeKeyMappable {
    public static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
        return ["": []]
    }
}

// MARK: - 解码value转化协议
public protocol DecodeValueMappable {
    // MARK: - Bool
    static func toBool(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Bool

    // MARK: - Int
    static func toInt(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int

    // MARK: - Int8
    static func toInt8(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int8

    // MARK: - Int16
    static func toInt16(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int16

    // MARK: - Int32
    static func toInt32(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int32

    // MARK: - Int64
    static func toInt64(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int64

    // MARK: - UInt
    static func toUInt(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt

    // MARK: - UInt8
    static func toUInt8(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt8

    // MARK: - UInt16
    static func toUInt16(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt16

    // MARK: - UInt32
    static func toUInt32(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt32

    // MARK: - UInt64
    static func toUInt64(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt64

    // MARK: - Float
    static func toFloat(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Float

    // MARK: - Double
    static func toDouble(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Double

    // MARK: - String
    static func toString(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> String

    // MARK: - Data
    static func toData(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Data

    // MARK: - Date
    static func toDate(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Date

    // MARK: - URL
    static func toURL(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> URL
}

// MARK: - BOOL
extension DecodeValueMappable {
    static func toBool(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Bool {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxBool(json: json).bool
        case .bool(let bool): return bool
        case .string(let string): return Bool(string) ?? BoxBool(json: json).bool
        case .integer(let integer): return integer == 1 ? true : false
        case .double(_): return json == 1 ? true : false
        case .object(_): return BoxBool(json: json).bool
        case .array(_): return BoxBool(json: json).bool
        }
    }
}

// MARK: - INT
extension DecodeValueMappable {
    static func toInt(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxInt(json: json).int
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int(string) ?? BoxInt(json: json).int
        case .integer(let integer): return Int(integer)
        case .double(let double): return Int(double)
        case .object(_): return BoxInt(json: json).int
        case .array(_): return BoxInt(json: json).int
        }
    }
}

// MARK: - INT8
extension DecodeValueMappable {
    static func toInt8(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int8 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxInt8(json: json).int8
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int8(string) ?? BoxInt8(json: json).int8
        case .integer(let integer): return Int8(integer)
        case .double(let double): return Int8(double)
        case .object(_): return BoxInt8(json: json).int8
        case .array(_): return BoxInt8(json: json).int8
        }
    }
}

// MARK: - INT16
extension DecodeValueMappable {
    static func toInt16(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int16 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxInt16(json: json).int16
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int16(string) ?? BoxInt16(json: json).int16
        case .integer(let integer): return Int16(integer)
        case .double(let double): return Int16(double)
        case .object(_): return BoxInt16(json: json).int16
        case .array(_): return BoxInt16(json: json).int16
        }
    }
}

// MARK: - INT32
extension DecodeValueMappable {
    static func toInt32(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int32 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxInt32(json: json).int32
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int32(string) ?? BoxInt32(json: json).int32
        case .integer(let integer): return Int32(integer)
        case .double(let double): return Int32(double)
        case .object(_): return BoxInt32(json: json).int32
        case .array(_): return BoxInt32(json: json).int32
        }
    }
}

// MARK: - INT64
extension DecodeValueMappable {
    static func toInt64(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Int64 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxInt64(json: json).int64
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return Int64(string) ?? BoxInt64(json: json).int64
        case .integer(let integer): return Int64(integer)
        case .double(let double): return Int64(double)
        case .object(_): return BoxInt64(json: json).int64
        case .array(_): return BoxInt64(json: json).int64
        }
    }
}

// MARK: - UINT
extension DecodeValueMappable {
    static func toUInt(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxUInt(json: json).uint
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt(string) ?? BoxUInt(json: json).uint
        case .integer(let integer): return integer >= 0 ? UInt(integer) : BoxUInt(json: json).uint
        case .double(let double): return double >= 0 ? UInt(double) : BoxUInt(json: json).uint
        case .object(_): return BoxUInt(json: json).uint
        case .array(_): return BoxUInt(json: json).uint
        }
    }
}

// MARK: - UInt8
extension DecodeValueMappable {
    static func toUInt8(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt8 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxUInt8(json: json).uint8
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt8(string) ?? BoxUInt8(json: json).uint8
        case .integer(let integer): return integer >= 0 ? UInt8(integer) : BoxUInt8(json: json).uint8
        case .double(let double): return double >= 0 ? UInt8(double) : BoxUInt8(json: json).uint8
        case .object(_): return BoxUInt8(json: json).uint8
        case .array(_): return BoxUInt8(json: json).uint8
        }
    }
}

// MARK: - UInt16
extension DecodeValueMappable {
    static func toUInt16(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt16 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxUInt16(json: json).uint16
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt16(string) ?? BoxUInt16(json: json).uint16
        case .integer(let integer): return integer >= 0 ? UInt16(integer) : BoxUInt16(json: json).uint16
        case .double(let double): return double >= 0 ? UInt16(double) : BoxUInt16(json: json).uint16
        case .object(_): return BoxUInt16(json: json).uint16
        case .array(_): return BoxUInt16(json: json).uint16
        }
    }
}

// MARK: - UInt32
extension DecodeValueMappable {
    static func toUInt32(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt32 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxUInt32(json: json).uint32
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt32(string) ?? BoxUInt32(json: json).uint32
        case .integer(let integer): return integer >= 0 ? UInt32(integer) : BoxUInt32(json: json).uint32
        case .double(let double): return double >= 0 ? UInt32(double) : BoxUInt32(json: json).uint32
        case .object(_): return BoxUInt32(json: json).uint32
        case .array(_): return BoxUInt32(json: json).uint32
        }
    }
}

// MARK: - UInt64
extension DecodeValueMappable {
    static func toUInt64(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> UInt64 {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxUInt64(json: json).uint64
        case .bool(let bool): return bool == true ? 1 : 0
        case .string(let string): return UInt64(string) ?? BoxUInt64(json: json).uint64
        case .integer(let integer): return integer >= 0 ? UInt64(integer) : BoxUInt64(json: json).uint64
        case .double(let double): return double >= 0 ? UInt64(double) : BoxUInt64(json: json).uint64
        case .object(_): return BoxUInt64(json: json).uint64
        case .array(_): return BoxUInt64(json: json).uint64
        }
    }
}

// MARK: - Float
extension DecodeValueMappable {
    static func toFloat(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Float {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxFloat(json: json).float
        case .bool(let bool): return bool == true ? 1 : 0
        case let .string(string):
            switch decoder.strategy.value.nonConformingFloat {
            case .convertToZero(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
                    throw Coding.Exception.rule(sets: positiveInfinity, positiveInfinity, negativeInfinity)
                }
                if positiveInfinity.contains(string) {
                    return 0
                } else if negativeInfinity.contains(string) {
                    return 0
                } else if nan.contains(string) {
                    return 0
                }
                return Float(string) ?? BoxFloat(json: json).float
            case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
                    throw Coding.Exception.rule(sets: positiveInfinity, positiveInfinity, negativeInfinity)
                }
                if positiveInfinity.contains(string) {
                    return Float.infinity
                } else if negativeInfinity.contains(string) {
                    return -Float.infinity
                } else if nan.contains(string) {
                    return Float.nan
                }
                return Float(string) ?? BoxFloat(json: json).float
            }
        case .integer(let integer): return Float(integer)
        case .double(let double): return Float(double)
        case .object(_): return BoxFloat(json: json).float
        case .array(_): return BoxFloat(json: json).float
        }
    }
}

// MARK: - Double
extension DecodeValueMappable {
    static func toDouble(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Double {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxDouble(json: json).double
        case .bool(let bool): return bool == true ? 1 : 0
        case let .string(string):
            switch decoder.strategy.value.nonConformingFloat {
            case .convertToZero(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
                    throw Coding.Exception.rule(sets: positiveInfinity, positiveInfinity, negativeInfinity)
                }
                if positiveInfinity.contains(string) {
                    return 0
                } else if negativeInfinity.contains(string) {
                    return 0
                } else if nan.contains(string) {
                    return 0
                }
                return Double(string) ?? BoxDouble(json: json).double
            case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
                    throw Coding.Exception.rule(sets: positiveInfinity, positiveInfinity, negativeInfinity)
                }
                if positiveInfinity.contains(string) {
                    return Double.infinity
                } else if negativeInfinity.contains(string) {
                    return -Double.infinity
                } else if nan.contains(string) {
                    return Double.nan
                }
                return Double(string) ?? BoxDouble(json: json).double
            }
        case .integer(let integer): return Double(integer)
        case .double(let double): return Double(double)
        case .object(_): return BoxDouble(json: json).double
        case .array(_): return BoxDouble(json: json).double
        }
    }
}

// MARK: - String
extension DecodeValueMappable {
    static func toString(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> String {
        switch json {
        case .unknow: throw Coding.Exception.unknow()
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
extension DecodeValueMappable {
    static func toData(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Data {
        let inner: InnerDecoder = InnerDecoder(json: json, decoder: decoder)
        switch json {
        case .unknow: throw Coding.Exception.unknow()
        case .null: return BoxData(json: json).data
        case .bool(_): return BoxData(json: json).data
        case .integer(let integer):
            switch inner.decoder?.strategy.value.data ?? .useDefaultValues {
            case .base64: return integer.toData()?.base64EncodedData() ?? BoxData(json: json).data.base64EncodedData()
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: json)
                var json = json
                return Data(bytes: &json, count: size)
            case .useDefaultValues: return BoxData(json: json).data
            case .hexadecimalValues: return BoxData(json: json).data
            case .custom(let closure):
                do {
                     return try closure(inner)
                } catch {
                    return BoxData(json: json).data
                }
            }
        case .double(let double):
            switch inner.decoder?.strategy.value.data ?? .useDefaultValues {
            case .base64: return double.toData()?.base64EncodedData() ?? BoxData(json: json).data.base64EncodedData()
            case .useDefaultValues: return BoxData(json: json).data
            case .hexadecimalValues: return BoxData(json: json).data
            case .custom(let closure):
                do {
                    return try closure(inner)
                } catch {
                    return BoxData(json: json).data
                }
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: json)
                var json = json
                return Data(bytes: &json, count: size)
            }
        case .string(let string):
            switch inner.decoder?.strategy.value.data ?? .useDefaultValues {
            case .base64: return string.toData()?.base64EncodedData() ?? BoxData(json: json).data.base64EncodedData()
            case .useDefaultValues: return json.dataWrapper ?? Data()
            case .hexadecimalValues: return Data(hexString: string)
            case .custom(let closure):
                do {
                    return try closure(inner)
                } catch {
                    return json.dataWrapper ?? Data()
                }
            case .deferredToData:
                let size = MemoryLayout.size(ofValue: json)
                var json = json
                return Data(bytes: &json, count: size)
            }
        case .object(_): return BoxData(json: json).data
        case .array(_): return BoxData(json: json).data
        }
    }
}

// MARK: - URL
extension DecodeValueMappable {
    static func toURL(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> URL {
        switch json {
        case .unknow: throw Coding.Exception.transform()
        case .null: return BoxURL(json: json).url
        case .bool(_): return BoxURL(json: json).url
        case .integer(_): return BoxURL(json: json).url
        case .double(_): return BoxURL(json: json).url
        case .string(let string):
            do {
                return try URL.buildURL(string: string)
            } catch {
                return BoxURL(json: json).url
            }
        case .object(_): return BoxURL(json: json).url
        case .array(_): return BoxURL(json: json).url
        }
    }
}

// MARK: - Date
extension DecodeValueMappable {
    static func toDate(decoder: PowerJSONDecoder, paths: [Path], json: JSON) throws -> Date {
        let inner: InnerDecoder = InnerDecoder(json: json, decoder: decoder)
        switch json {
        case .unknow: throw Coding.Exception.transform()
        case .null: return BoxDate(json: json).date
        case .bool(_): return BoxDate(json: json).date
        case .integer(let integer):
            switch decoder.strategy.value.date {
            case .custom(let closure):
                do {
                    return try closure(inner, decoder.paths, json)
                } catch  {
                    return BoxDate(json: json).date
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
            switch decoder.strategy.value.date {
            case .custom(let closure):
                do {
                    return try closure(inner, decoder.paths, json)
                } catch  {
                   return BoxDate(json: json).date
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
            switch decoder.strategy.value.date {
            case .custom(let closure):
                do {
                    return try closure(inner, decoder.paths, json)
                } catch  {
                    return BoxDate(json: json).date
                }
            case .secondsSince1970(let form):
                guard let double = TimeInterval(string) else { return BoxDate(json: json).date }
                switch form {
                case .second:
                    return Date(timeIntervalSince1970: TimeInterval(double))
                case .millisecond:
                    return Date(timeIntervalSince1970: TimeInterval(double / 1000.0))
                }
            case .millisecondsSince1970(json: let form):
                guard let double = TimeInterval(string) else { return BoxDate(json: json).date }
                switch form {
                case .second: return Date(timeIntervalSince1970: TimeInterval(double))
                case .millisecond: return Date(timeIntervalSince1970: TimeInterval(double / 1000.0))
                }
            case .utc, .deferredToDate:
                let formatter = DateFormatter.utc()
                guard let date: Date = formatter.date(from: string) else { return BoxDate(json: json).date }
                return date
            case .iso8601:
                let formatter = DateFormatter.iso8601()
                guard let date: Date = formatter.date(from: string) else { return BoxDate(json: json).date }
                return date
            }
        case .object(_): return BoxDate(json: json).date
        case .array(_): return BoxDate(json: json).date
        }
    }
}

// MARK: - 编码key转化协议
public protocol EncodeKeyMappable {
    /// 可转变的keys
    /// /// 优先级是策略中最高的 如果制定了编码器的Key策略,同时也实现了该协议,最终是该协议生效而不是设置编码器Key的生效
    static func modelEncodeKeys(decoder: PowerJSONEncoder, paths: [Path]) -> [String: String]
}

extension EncodeKeyMappable {
    static func modelEncodeKeys(decoder: PowerJSONEncoder, paths: [Path]) -> [String: String] {
        return ["": ""]
    }
}

// MARK: - 编码value转化协议
public protocol EncodingValueMappable {
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerNull) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerBool) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerInteger) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerDouble) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerString) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerObject) -> JSON
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerArray) -> JSON
}

extension EncodingValueMappable {
    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerNull) -> JSON {
        return JSON(nilLiteral: ())
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerBool) -> JSON {
        return JSON(booleanLiteral: value)
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerInteger) -> JSON {
        return JSON(integerLiteral: IntegerLiteralType(value))
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerDouble) -> JSON {
        return JSON(floatLiteral: value)
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerString) -> JSON {
        return JSON(stringLiteral: value)
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerObject) -> JSON {
        return JSON(object: value)
    }

    static func toJSON(decoder: PowerJSONEncoder, paths: [Path], value: PowerArray) -> JSON {
        return JSON(array: value)
    }
}

public protocol CodingSupport {
    /// JSON的二进制数据
    var dataWrapper: Data? { get }
    /// 关联类型
    associatedtype Wrapper
}

extension Data: CodingSupport {
    public typealias Wrapper = Data
    public var dataWrapper: Data? {
        return self
    }
}

extension String: CodingSupport {
    public typealias Wrapper = String
    public var dataWrapper: Data? {
        return self.data(using: Encoding.utf8)
    }
}

/// 对内存中的json结构对象进行描述 用它包裹真实的son( [:],[])这俩种
public struct JSONWrapper: CodingSupport {
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

    init(wrapper: [Any]) {
        self.json = wrapper
    }
    
    init(wrapper: [String: Any]) {
        self.json = wrapper
    }
}

extension JSON: CodingSupport {
    public typealias Wrapper = JSON

    public var dataWrapper: Data? {
        do {
            let string: String = try JSON.Serializer.serialize(self)
            return string.data(using: String.Encoding.utf8)
        } catch  {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

extension Dictionary: CodingSupport where Key == String, Value == Any {
    public typealias Wrapper = Dictionary
    public var dataWrapper: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

extension Array: CodingSupport where Element == Any {
    public var dataWrapper: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    public typealias Wrapper = Array
}


public extension Decodable {
    /// Decodable解码类型是否为数组
    static func array() -> Bool {
        if Self.self is [Bool].Type || Self.self is [Int].Type || Self.self is [Int8].Type || Self.self is [Int16].Type || Self.self is [Int32].Type || Self.self is [Int64].Type || Self.self is [UInt].Type || Self.self is [UInt8].Type || Self.self is [UInt16].Type || Self.self is [UInt32].Type || Self.self is [UInt64].Type || Self.self is [Float].Type || Self.self is [Double].Type || Self.self is [String].Type || Self.self is [Decodable].Type || Self.self is [Codable].Type {
            return true
        }
        return false
    }
}
