import Foundation

public struct DecodingStrategy {
    ///  nil转化为可选类型开关 如果开启的话 nil -> Type? 则不一定会生成 nil值 取决于用户自己根据需求
    /// 这个策略是指模型的字段在经过策略处理后(snake camel, pascal, upper, lower)该字段会已这种处理后的表现形式在进行解码处理
    /// 例如 模型字段 var stringData: String经过snake处理成为string_data, 经历camel处理成为stringData, 经历pascal处理成为string-data, 经历upper处理成为STRINGDATE, 经历lower处理成为stringdata, 再进行写一步处理. 该策略是全局的会影响所有的字段解析
    var keysMapping: PowerJSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    var valuesMapping: ValueStrategy = .useDefaultValues
}

public final class PowerJSONDecoder {
    public var strategy = DecodingStrategy()

    /// 正向模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - from: 数据源, 只支持[Data String JSONStructure(json结构) JSON]
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T, U>(type: T.Type, from: U) throws -> T where T: Decodable, U: JSONCodingSupport {
        guard let data: Data = from.dataWrapper else {
            throw CodingError.notFoundData()
        }
        do {
            let json: JSON = try JSON.Parser.parse(data)
            let decoder = PowerInnerJSONDecoder(json: json)
            decoder.wrapper = self
            return try decoder.unboxDecodable(object: json)
        } catch {
            throw error
        }
    }
}

final class PowerInnerJSONDecoder: Decoder {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey : Any] = [:]
    var json: JSON
    var currentJSON: JSON
    unowned var wrapper: PowerJSONDecoder?
    var mappingKeys: [String: [String]]?
    var paths: [Path] = []

    init(json: JSON, at codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
        self.json = json
        self.currentJSON = json
    }
}

extension PowerInnerJSONDecoder {
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try container(keyedBy: type, wrapping: currentJSON)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try unkeyedContainer(wrapping: currentJSON)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return DecodingSingleValue(decoder: self, json: currentJSON)
    }
}

extension PowerInnerJSONDecoder {
    func container<Key>(keyedBy type: Key.Type, wrapping object: JSON) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        guard case let .object(unwrappedObject) = object else {
            throw CodingError.Decoding.typeMismatch(type: [String: JSON].self, codingPath: self.codingPath, reality: object)
        }
        let container = DecodingKeyed<Key>(decoder: self, json: unwrappedObject)
        return KeyedDecodingContainer(container)
    }

    func unkeyedContainer(wrapping object: JSON) throws -> UnkeyedDecodingContainer {
        guard case let .array(array) = object else {
            throw CodingError.Decoding.typeMismatch(type: [JSON].self, codingPath: self.codingPath, reality: object)
        }
        return DecodingUnkeyed(decoder: self, json: array)
    }
}

extension PowerInnerJSONDecoder: ValueConvertible {}

// MARK: - Keyed和Unkeyed解码
extension PowerInnerJSONDecoder {
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

    /// 整型解码处理
    /// - Parameter object: json对象
    /// - Throws: 解码key
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON) throws -> T where T: BinaryFloatingPoint, T: LosslessStringConvertible {
        switch object {
        case let .integer(number):
            guard let integer = T(exactly: number) else { throw CodingError.Decoding.numberMisfit(type: T.self, codingPath: self.codingPath , reality: number) }
            return integer
        case let .double(number):
            switch T.self {
            case is Double.Type:
                guard let double = Double(exactly: number) else { throw CodingError.Decoding.numberMisfit(type: T.self, codingPath: self.codingPath, reality: number) }
                return double as! T
            case is Float.Type:
                guard let float = Float(exactly: number) else { throw CodingError.Decoding.numberMisfit(type: T.self, codingPath: self.codingPath, reality: number) }
                return float as! T
            default:
                fatalError()
            }
        case let .bool(bool):
            return bool ? 1 : 0
        case let .string(string):
            switch self.wrapper?.strategy.valuesMapping ?? .useDefaultValues {
            case .useDefaultValues:
                if self.toPositiveInfinity(path: self.paths.jsonPath, value: string).contains(string) {
                    return T.infinity
                } else if self.toNegativeInfinity(path: self.paths.jsonPath, value: string).contains(string) {
                    return -T.infinity
                } else if self.toNan(path: self.paths.jsonPath, value: string).contains(string) {
                    return T.nan
                }
                debugPrint("Error: \(string) can't transform. return default value 0")
                return 0
            case .useCustomValues(delegete: let delegete, enableMappingEmptyValue: _):
                if delegete.toPositiveInfinity(path: self.paths.jsonPath, value: string).contains(string) {
                    return T.infinity
                } else if delegete.toNegativeInfinity(path: self.paths.jsonPath, value: string).contains(string) {
                    return -T.infinity
                } else if delegete.toNan(path: self.paths.jsonPath, value: string).contains(string) {
                    return T.nan
                }
                debugPrint("Error: \(string) can't transform. return default value 0")
                return 0
            }
        default:
            throw CodingError.Decoding.typeMismatch(type: T.self, codingPath: self.codingPath, reality: object)
        }
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

    /// 整型解码处理
    /// - Parameters:
    ///   - object: json对象
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(object: JSON) throws -> T where T: FixedWidthInteger {
        switch object {
        case let .integer(number):
            guard let integer = T(exactly: number) else {
                throw  CodingError.Decoding.numberMisfit(type: T.self, reality: number)
            }
            return integer
        case let .double(number):
            guard let double = T(exactly: number) else {
                throw CodingError.Decoding.numberMisfit(type: T.self, reality: number)
            }
            return double
        case let .string(string):
            guard let number = T(string) else { fallthrough }
            return number
        default:
            throw CodingError.Decoding.typeMismatch(type: T.self, reality: object)
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
        if let type: MappingDecodingKeys.Type = T.self as? MappingDecodingKeys.Type {
            self.mappingKeys = type.modelDecodingKeys()
        }
        if T.self == URL.self, object.isString$ {
            let container = DecodingSingleValue(decoder: self, json: currentJSON)
            return try container.decode(T.self)
        } else if T.self == Date.self {
            return try T.init(from: self)
        } else if T.self == Data.self {
            let container = DecodingSingleValue(decoder: self, json: currentJSON)
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
        switch self.wrapper?.strategy.valuesMapping ?? .useDefaultValues {
        case .useDefaultValues:
            return object == .null
        case .useCustomValues(delegete: _, enableMappingEmptyValue: let isEnable):
            if isEnable && object == .null {
                return false
            } else {
                return object == .null
            }
        }
    }
}

// MARK: - SingleValue解码
extension PowerInnerJSONDecoder {
    func unbox(object: JSON) throws -> Bool {
        switch object {
        case let .bool(bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: bool)
            }
        case let .integer(integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: integer)
            }
        case let .double(double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: double)
            }
        case let .string(string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: string)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: array)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: object)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toBool(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toBool(path: self.paths.jsonPath, value: NSNull())
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Int {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Int8 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt8(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt8(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Int16 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt16(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt16(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Int32 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt32(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt32(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Int64 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toInt64(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toInt64(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> UInt {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> UInt8 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt8(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt8(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> UInt16 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt16(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt16(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> UInt32 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt32(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt32(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> UInt64 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toUInt64(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toUInt64(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Float {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toFloat(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toFloat(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> Double {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toDouble(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toDouble(path: self.paths.jsonPath, value: double)
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func unbox(object: JSON) throws -> String {
        switch object {
        case let .bool(bool):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: bool)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: bool)
            }
        case let .integer(integer):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: integer)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: integer)
            }
        case let .double(double):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: double)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: double)
            }
        case let .string(string):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: string)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: string)
            }
        case .array(let array):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: array)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: array)
            }
        case .object(let object):
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: object)
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: object)
            }
        case .null:
            switch self.wrapper?.strategy.valuesMapping {
            case .useDefaultValues, .none: return self.toString(path: self.paths.jsonPath, value: NSNull())
            case .useCustomValues(delegete: let delegate, enableMappingEmptyValue: _): return delegate.toString(path: self.paths.jsonPath, value: NSNull())
            }
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }
}
