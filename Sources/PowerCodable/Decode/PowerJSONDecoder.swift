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
    
    var keysStore: [[String: [String]]] = []
    var valuesStore: [DecodeValueMappable.Type] = []
    
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

// MARK: -  空(nil)处理
extension InnerDecoder {
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

// MARK: -  Bool处理
extension InnerDecoder {
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
    
    func unbox(object: JSON) throws -> Bool {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toBool(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toBool(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toBool(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Int处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Int {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Int {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Int8处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Int8 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Int8 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Int16处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Int16 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Int16 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Int32处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Int32 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Int32 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Int64处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Int64 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Int64 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  UInt处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> UInt {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> UInt {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  UInt8处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> UInt8 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> UInt8 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt8(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  UInt16处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> UInt16 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> UInt16 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt16(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  UInt32处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> UInt32 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> UInt32 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt32(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  UInt64处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> UInt64 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> UInt64 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt64(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  String处理
extension InnerDecoder {
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
    
    func unbox(object: JSON) throws -> String {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toString(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toString(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toString(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Float处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Float {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Float {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toFloat(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toFloat(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toFloat(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  Double处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - object: json对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(object: JSON, forKey key: CodingKey) throws -> Double {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(object: object)
    }
    
    func unbox(object: JSON) throws -> Double {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toDouble(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
        } else {
            switch self.wrapper?.strategy.valueMappable ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toDouble(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toDouble(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths, value: object)
            }
        }
    }
}

// MARK: -  范型T处理
extension InnerDecoder {
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
        print(Swift.type(of: T.self))
        if let type: DecodeKeyMappable.Type = T.self as? DecodeKeyMappable.Type {
            self.keysStore.append(type.modelDecodeKeys(decoder: self.wrapper ?? PowerJSONDecoder(), paths: self.paths))
        }
        if let type: DecodeValueMappable.Type = T.self as? DecodeValueMappable.Type {
            self.valuesStore.append(type)
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
        defer {
            if self.keysStore.count > 0 {
                self.keysStore.removeLast()
            }
            if self.valuesStore.count > 0 {
                self.valuesStore.removeLast()
            }
        }
        debugPrint(Swift.type(of: T.self))
        return try T.init(from: self)
    }
}
