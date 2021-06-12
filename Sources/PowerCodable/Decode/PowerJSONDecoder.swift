import Foundation

/// 策略统一封装
public struct DecodingStrategy {
    ///  nil转化为可选类型开关 如果开启的话 nil -> Type? 则不一定会生成 nil值 取决于用户自己根据需求
    /// 这个策略是指模型的字段在经过策略处理后(snake camel, pascal, upper, lower)该字段会已这种处理后的表现形式在进行解码处理
    /// 例如 模型字段 var stringData: String经过snake处理成为string_data, 经历camel处理成为stringData, 经历pascal处理成为string-data, 经历upper处理成为STRINGDATE, 经历lower处理成为stringdata, 再进行下一步处理. 该策略是全局的会影响所有的字段解析
    public var keyMappable: PowerJSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    /// 针对一般情况下的值处理
    public var valueMappable: PowerJSONDecoder.ValueDecodingStrategy = .useDefaultValues
    /// 针对转Data处理
    public var dataValueMappable: PowerJSONDecoder.DataDecodingStrategy = .useDefaultValues
    /// 针对转Date处理
    public var dateValueMappable: PowerJSONDecoder.DateDecodingStrategy = .secondsSince1970(json: .second)
    /// 针对浮点型值(nan, +infinity, -infinity)处理
    public var nonConformingFloatValueMappable: PowerJSONDecoder.NonConformingFloatDecodingStrategy = .convertToString()
    /// 仅仅针对nil值转为T?的处理,false则不能接受自定义的nil处理,true则接受自定义的nil处理
    public var enableMappableEmptyValue: Bool = false
    
    /// 针对树形结构中存在的任意的一个节点开始解码(包含此节点,节点必须也是容器结构,通俗讲就是随便选去一个数组或字典进行解码)
    public var startPaths: [Path]? = nil
}

public final class PowerJSONDecoder {
    public var strategy = DecodingStrategy()
    /// 编码路径
    var paths: [Path] = []

    /// 正向模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - from: 数据源, 只支持[Data String JSONWrapper(json结构) JSON](必须是容器类)
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T, U>(type: T.Type, from: U) throws -> T where T: Decodable, U: CodingSupport {
        guard let data: Data = from.dataWrapper else { throw Coding.Exception.invalidData() }
        do {
            let json: JSON = try JSON.Parser.parse(data)
            if type == JSON.self {
                return json as! T
            }
            let decoder = InnerDecoder(json: json)
            decoder.wrapper = self
            let use: JSON = self.strategy.startPaths?.reduce(json) { (result, path) -> JSON in
                switch result {
                case .array(_): return json[path.intValue ?? 0] ?? JSON.unknow
                case .object(_): return json[path.stringValue] ?? JSON.unknow
                default: fatalError()
                }
            } ?? json
            return try decoder.unboxDecodable(object: use)
        } catch {
            throw error
        }
    }
}

final class InnerDecoder: Decoder {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey : Any] = [:]
    var json: JSON
    var currentJSON: JSON
    unowned var wrapper: PowerJSONDecoder?
    var MappableKeys: [String: [String]]?

    var paths: [Path] {
        get { return self.wrapper?.paths ?? [] }
        set { self.wrapper?.paths = newValue }
    }

    init(json: JSON, at codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
        self.json = json
        self.currentJSON = json
    }
}

extension InnerDecoder {
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try container(keyedBy: type, wrapping: currentJSON)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try unkeyedContainer(wrapping: currentJSON)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return DecodeSingleValue(decoder: self, json: currentJSON)
    }
}

extension InnerDecoder {
    func container<Key>(keyedBy type: Key.Type, wrapping object: JSON) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        guard case let .object(unwrappedObject) = object else {
            throw Coding.Exception.typeMismatch(type: [String: JSON].self, codingPath: self.codingPath, reality: object)
        }
        let container = DecodeKeyed<Key>(decoder: self, json: unwrappedObject)
        return KeyedDecodingContainer(container)
    }

    func unkeyedContainer(wrapping object: JSON) throws -> UnkeyedDecodingContainer {
        guard case let .array(array) = object else {
            throw Coding.Exception.typeMismatch(type: [JSON].self, codingPath: self.codingPath, reality: object)
        }
        return DecodeUnkeyed(decoder: self, json: array)
    }
}

extension InnerDecoder: DecodeValueMappable {}

// MARK: - Keyed和Unkeyed解码
extension InnerDecoder {
    /// 浮点型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON, forKey key: CodingKey) throws -> T where T: BinaryFloatingPoint, T: LosslessStringConvertible {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    /// 浮点型(Float, Doube, Float80)解码处理
    /// - Parameter object: json对象
    /// - Throws: 解码key
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON) throws -> T where T: BinaryFloatingPoint, T: LosslessStringConvertible {
        if T.self == Float.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toFloat(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toFloat(paths: self.paths, value: object))
            }
        } else if T.self == Double.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toDouble(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toDouble(paths: self.paths, value: object))
            }
        } else if T.self == Float80.self {
            throw Coding.Exception.invalidTransform()
        } else {
            throw Coding.Exception.invalidTransform()
        }
//        switch object {
//        case let .integer(number):
//            guard let integer = T(exactly: number) else { throw Coding.Exception.numberMisfit(type: T.self, codingPath: self.codingPath , reality: number) }
//            return integer
//        case let .double(number):
//            switch T.self {
//            case is Double.Type:
//                guard let double = Double(exactly: number) else { throw Coding.Exception.numberMisfit(type: T.self, codingPath: self.codingPath, reality: number) }
//                return double as! T
//            case is Float.Type:
//                guard let float = Float(exactly: number) else { throw Coding.Exception.numberMisfit(type: T.self, codingPath: self.codingPath, reality: number) }
//                return float as! T
//            default:
//                fatalError()
//            }
//        case let .bool(bool):
//            return bool ? 1 : 0
//        case let .string(string):
//            switch self.wrapper?.strategy.nonConformingFloatValueMappable ?? .convertToZero() {
//            case .convertToZero(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
//                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
//                    throw Coding.Exception.invalidRule(sets: positiveInfinity, positiveInfinity, negativeInfinity)
//                }
//                if positiveInfinity.contains(string) {
//                    return 0
//                } else if negativeInfinity.contains(string) {
//                    return 0
//                } else if nan.contains(string) {
//                    return 0
//                }
//                guard let number = T(string) else { throw Coding.Exception.invalidTransform() }
//                return number
//            case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
//                if (positiveInfinity &~ negativeInfinity &~ nan).count != 0 {
//                    throw Coding.Exception.typeMismatch(type: T.self, codingPath: self.codingPath, reality: object)
//                }
//                if positiveInfinity.contains(string) {
//                    return T.infinity
//                } else if negativeInfinity.contains(string) {
//                    return -T.infinity
//                } else if nan.contains(string) {
//                    return T.nan
//                }
//                guard let number = T(string) else { throw Coding.Exception.invalidTransform() }
//                return number
//            }
//        default:
//            throw Coding.Exception.typeMismatch(type: T.self, codingPath: self.codingPath, reality: object)
//        }
    }

    /// 整型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON, forKey key: CodingKey) throws -> T where T: FixedWidthInteger {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    /// 整型(Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64)解码处理
    /// - Parameters:
    ///   - object: json对象(数据源)
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON) throws -> T where T: FixedWidthInteger {
        if T.self == Int.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toInt(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toInt(paths: self.paths, value: object))
            }
        } else if T.self == Int8.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toInt8(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toInt8(paths: self.paths, value: object))
            }
        } else if T.self == Int16.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toInt16(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toInt16(paths: self.paths, value: object))
            }
        } else if T.self == Int32.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toInt32(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toInt32(paths: self.paths, value: object))
            }
        } else if T.self == Int64.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toInt64(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toInt64(paths: self.paths, value: object))
            }
        } else if T.self == UInt.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toUInt(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toUInt(paths: self.paths, value: object))
            }
        } else if T.self == UInt8.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toUInt8(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toUInt8(paths: self.paths, value: object))
            }
        } else if T.self == UInt16.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toUInt16(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toUInt16(paths: self.paths, value: object))
            }
        } else if T.self == UInt32.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toUInt32(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toUInt32(paths: self.paths, value: object))
            }
        } else if T.self == UInt64.self {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return T(try InnerDecoder.toUInt64(paths: self.paths, value: object))
            case .useCustomValues(delegete: let delegete):
                return T(try Swift.type(of: delegete).toUInt64(paths: self.paths, value: object))
            }
        } else {
            throw Coding.Exception.invalidTransform()
        }
    }

    /// 布尔型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> String {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    /// T型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unboxDecodable<T>(object: JSON, forKey key: CodingKey) throws -> T where T: Decodable {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unboxDecodable(object: object)
    }

    /// 解码顶层处理
    /// - Parameter object: json对象
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unboxDecodable<T>(object: JSON) throws -> T where T: Decodable {
        currentJSON = object
        if let type: DecodeKeyMappable.Type = T.self as? DecodeKeyMappable.Type {
            self.MappableKeys = type.decodeKeys()
        }
        if T.self == URL.self {
            let container = DecodeSingleValue(decoder: self, json: currentJSON)
            return try container.decode(T.self)
        } else if T.self == Date.self {
            let container = DecodeSingleValue(decoder: self, json: currentJSON)
            return try container.decode(T.self)
        } else if T.self == Data.self {
            let container = DecodeSingleValue(decoder: self, json: currentJSON)
            return try container.decode(T.self)
        }
        return try T.init(from: self)
    }

    /// 是否解码空
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Returns: 是否为空
    func unboxNil(object: JSON, forKey key: CodingKey) -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return unboxNil(object: object)
    }

    /// 是否解码空
    /// - Parameter object: json对象
    /// - Returns: 是否为空
    func unboxNil(object: JSON) -> Bool {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return object == .null
        case .useCustomValues(delegete: _):
            if (self.wrapper?.strategy.enableMappableEmptyValue ?? false) && object == .null {
                return false
            } else {
                return object == .null
            }
        }
    }
}

// MARK: - SingleValue解码
extension InnerDecoder {
    func unbox(object: JSON) throws -> Bool {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toBool(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toBool(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Int {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toInt(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toInt(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Int8 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toInt8(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toInt8(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Int16 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toInt16(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toInt16(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Int32 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toInt32(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toInt32(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Int64 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toInt64(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toInt64(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> UInt {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toUInt(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toUInt(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> UInt8 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toUInt8(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toUInt8(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> UInt16 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toUInt16(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toUInt16(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> UInt32 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toUInt32(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toUInt32(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> UInt64 {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toUInt64(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toUInt64(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Float {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toFloat(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toFloat(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> Double {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toDouble(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toDouble(paths: self.paths, value: object)
        }
    }

    func unbox(object: JSON) throws -> String {
        switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
        case .useDefaultValues:
            return try Self.self.toString(paths: self.paths, value: object)
        case .useCustomValues(delegete: let delegate):
            return try type(of: delegate).toString(paths: self.paths, value: object)
        }
    }
}
