import Foundation

public final class PowerJSONDecoder {
    /// 值转化策略
    public var valueConvertTypeStrategy: PowerJSONDecoder.ValueConvertTypeStrategy = .useDefaultable
    ///  nil转化为可选类型开关 如果开启的话 nil -> Type? 则不一定会生成 nil值 取决于用户自己根据需求
    public var customNilToOptionalType: Bool = false

    /// 正向模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - from: 数据源, 只支持[Data String Any(json结构)]
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T, U>(type: T.Type, from: U) throws -> T? where T: Decodable {
        do {
            if from is Data {
                guard let data = from as? Data else { return nil }
                let rootObject: JSON = try JSON.Parser.parse(data)
                let decoder = PowerInnerJSONDecoder(referencing: rootObject)
                decoder.wrapper = self
                return try decoder.unboxDecodable(object: rootObject)
            } else if from is String {
                guard let string = from as? String, let data = string.data(using: String.Encoding.utf8) else { return nil }
                let rootObject: JSON = try JSON.Parser.parse(data)
                let decoder = PowerInnerJSONDecoder(referencing: rootObject)
                decoder.wrapper = self
                return try decoder.unboxDecodable(object: rootObject)
            } else {
                if JSONSerialization.isValidJSONObject(from) {
                    let data: Data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
                    let rootObject: JSON = try JSON.Parser.parse(data)
                    let decoder = PowerInnerJSONDecoder(referencing: rootObject)
                    decoder.wrapper = self
                    return try decoder.unboxDecodable(object: rootObject)
                } else {
                    return nil
                }
            }
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON", underlyingError: error ))
        }
    }
}

public extension PowerJSONDecoder {
    /// 类型不一致策略
    enum ValueConvertTypeStrategy {
        case useDefaultable
        case useCustom(TypeConvertible)
    }
}



final class PowerInnerJSONDecoder: Decoder {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey : Any]
    var object: JSON
    var currentObject: JSON
    unowned var wrapper: PowerJSONDecoder?
    var mappingKeys: [String: [String]]?
    var paths: [Path] = []

    init(referencing object: JSON, at codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
        self.object = object
        self.userInfo = [:]
        self.currentObject = object
    }
}

extension PowerInnerJSONDecoder {
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
//        print(#function, "begin")
//        defer { print(#function, "end") }
        return try container(keyedBy: type, wrapping: currentObject)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
//        print(#function, "begin")
//        defer { print(#function, "end") }
        return try unkeyedContainer(wrapping: currentObject)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
//        print(#function, "begin")
//        defer { print(#function, "end") }
        return DecodingSingleValue(referencing: self, wrapping: currentObject)
    }
}

extension PowerInnerJSONDecoder {
    func container<Key>(keyedBy type: Key.Type, wrapping object: JSON) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        guard case let .object(unwrappedObject) = object else {
            throw typeMismatch(expectation: [String: JSON].self, reality: object)
        }

        let keyedContainer = DecodingKeyed<Key>(referencing: self, wrapping: unwrappedObject)
        return KeyedDecodingContainer(keyedContainer)
    }

    func unkeyedContainer(wrapping object: JSON) throws -> UnkeyedDecodingContainer {
        guard case let .array(array) = object else {
            throw typeMismatch(expectation: [String: JSON].self, reality: object)
        }
        return DecodingUnkeyed(referencing: self, wrapping: array)
    }
}

extension PowerInnerJSONDecoder: TypeConvertible {}

// MARK: - Keyed解码
extension PowerInnerJSONDecoder {
    func unbox<T>(object: JSON, forKey key: CodingKey) throws -> T where T: BinaryFloatingPoint, T: LosslessStringConvertible {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    func unbox<T>(object: JSON) throws -> T where T: BinaryFloatingPoint, T: LosslessStringConvertible {
        switch object {
        case let .integer(number):
            guard let integer = T(exactly: number) else { throw numberMisfit( expectation: T.self, reality: number) }
            return integer
        case let .double(number):
            switch T.self {
            case is Double.Type:
                guard let double = Double.init(exactly: number) else { throw numberMisfit(expectation: T.self, reality: number) }
                return double as! T
            case is Float.Type:
                guard let float = Float(exactly: number) else { throw numberMisfit(expectation: T.self, reality: number) }
                return float as! T
            default:
                fatalError()
            }
        case let .bool(bool):
            return bool ? 1 : 0
        case let .string(string):
            guard let number = T(string) else { fallthrough }
            return number
        default:
            throw typeMismatch(expectation: T.self, reality: object)
        }
    }

    func unbox<T>(object: JSON, forKey key: CodingKey) throws -> T where T: FixedWidthInteger {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    func unbox<T>(object: JSON) throws -> T where T: FixedWidthInteger {
        switch object {
        case let .integer(number):
            guard let integer = T(exactly: number) else {
                throw numberMisfit(expectation: T.self, reality: number)
            }
            return integer
        case let .double(number):
            guard let double = T(exactly: number) else {
                throw numberMisfit(expectation: T.self, reality: number)
            }
            return double
        case let .string(string):
            guard let number = T(string) else { fallthrough }
            return number
        default:
            throw typeMismatch(expectation: T.self, reality: object)
        }
    }

    func unbox(object: JSON, forKey key: CodingKey) throws -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    func unbox(object: JSON, forKey key: CodingKey) throws -> String {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }

    func unboxDecodable<T>(object: JSON, forKey key: CodingKey) throws -> T where T: Decodable {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unboxDecodable(object: object)
    }

    func unboxDecodable<T>(object: JSON) throws -> T where T: Decodable {
        currentObject = object
        guard let type: MappingDecodingKeys.Type = T.self as? MappingDecodingKeys.Type else {
            return try T.init(from: self)
        }
        self.mappingKeys = type.modelDecodingKeys()
        return try T.init(from: self)
    }

    func unboxNil(object: JSON, forKey key: CodingKey) -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        return unboxNil(object: object)
    }

    func unboxNil(object: JSON) -> Bool {
        return object == .null
    }
}

// MARK: - SingleValue解码
extension PowerInnerJSONDecoder {
    func unbox(object: JSON) throws -> Bool {
        switch object {
        case let .bool(bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: bool)
            }
        case let .integer(integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: integer)
            }
        case let .double(double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: double)
            }
        case let .string(string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: string)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: array)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: object)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toBool(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toBool(path: self.paths.jsonPath, value: NSNull())
            }
        }
    }

    func unbox(object: JSON) throws -> Int {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toInt(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Int8 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt8(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toInt8(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Int16 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt16(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toInt16(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Int32 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt32(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toInt32(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Int64 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toInt64(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toInt64(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> UInt {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toUInt(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> UInt8 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt8(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toUInt8(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> UInt16 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt16(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toUInt16(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> UInt32 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt32(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toUInt32(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> UInt64 {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toUInt64(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toUInt64(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Float {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toFloat(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toFloat(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> Double {
        switch object {
        case .bool(let bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: bool)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: object)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: array)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: NSNull())
            }
        case .string(let string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: string)
            }
        case .integer(let integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: integer)
            }
        case .double(let double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toDouble(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toDouble(path: self.paths.jsonPath, value: double)
            }
        }
    }

    func unbox(object: JSON) throws -> String {
        switch object {
        case let .bool(bool):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: bool)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: bool)
            }
        case let .integer(integer):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: integer)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: integer)
            }
        case let .double(double):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: double)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: double)
            }
        case let .string(string):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: string)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: string)
            }
        case .array(let array):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: array)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: array)
            }
        case .object(let object):
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: object)
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: object)
            }
        case .null:
            switch self.wrapper?.valueConvertTypeStrategy {
            case .useDefaultable, .none: return self.toString(path: self.paths.jsonPath, value: NSNull())
            case .useCustom(let delegate): return delegate.toString(path: self.paths.jsonPath, value: NSNull())
            }
        }
    }
}

extension PowerInnerJSONDecoder {
    private func typeMismatch(expectation: Any.Type, reality: JSON) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Expected to decode \(expectation) but found \(reality)) instead."
        )
        return DecodingError.typeMismatch(expectation, context)
    }

    private func numberMisfit(expectation: Any.Type, reality: CustomStringConvertible) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: "Parsed JSON number <\(reality)> does not fit in \(expectation)."
        )
        return DecodingError.dataCorrupted(context)
    }
}
