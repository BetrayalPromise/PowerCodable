import Foundation

public struct DecodingKey {
    /// key转化处理
    public var mapping: PowerJSONDecoder.KeyMappingDecodingStrategy = .useDefaultKeys
    ///  nil转化为可选类型开关 如果开启的话 nil -> Type? 则不一定会生成 nil值 取决于用户自己根据需求
    /// 这个策略是指模型的字段在经过策略处理后(snake camel, pascal, upper, lower)该字段会已这种处理后的表现形式在进行解码处理
    /// 例如 模型字段 var stringData: String经过snake处理成为string_data, 经历camel处理成为stringData, 经历pascal处理成为string-data, 经历upper处理成为STRINGDATE, 经历lower处理成为stringdata, 再进行下一步处理. 该策略是全局的会影响所有的字段解析(主要处理格式问题)
    public var formatting: PowerJSONDecoder.KeyFormatDecodingStrategy = .useDefaultKeys
}

public struct DecodingValue {
    /// 针对一般情况下的值处理
    public var mapping: PowerJSONDecoder.ValueDecodingStrategy = .useDefaultValues
    /// 仅仅针对nil值转为T?的处理,false则不能接受自定义的nil处理,true则接受自定义的nil处理
    public var enableEmpty: Bool = false
    /// 针对转Data处理
    public var data: PowerJSONDecoder.DataDecodingStrategy = .useDefaultValues
    /// 针对转Date处理
    public var date: PowerJSONDecoder.DateDecodingStrategy = .secondsSince1970(json: .second)
    /// 针对浮点型值(nan, +infinity, -infinity)处理
    public var nonConformingFloat: PowerJSONDecoder.NonConformingFloatDecodingStrategy = .convertToString()
}

/// 策略统一封装
public struct DecodingStrategy {
    /// 针对树形结构中存在的任意的一个节点开始解码(包含此节点,节点必须也是容器结构,通俗讲就是随便选去一个数组或字典进行解码)
    public var startPaths: [Path]? = nil
    public var value = DecodingValue()
    public var key = DecodingKey()
}

public final class PowerJSONDecoder {
    public var strategy = DecodingStrategy()
    /// 编码路径
    var paths: [Path] = []
    
    var inner: InnerDecoder?
    
    /// 正向模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - from: 数据源, 只支持[Data String JSONWrapper(json结构) JSON](必须是容器类)
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    public func decode<T, U>(type: T.Type, from: U) throws -> T where T: Decodable, U: CodingSupport {
        guard let data: Data = from.dataWrapper else { throw Coding.Exception.invalidData() }
        do {
            let json: JSON = try JSON.Parser.parse(data)
            if type == JSON.self {
                return json as! T
            }
            let inner = InnerDecoder(json: json, decoder: self)
            self.inner = inner
            let used: JSON = self.strategy.startPaths?.reduce(json) { (result, path) -> JSON in
                switch result {
                case .array(_): return json[path.intValue ?? 0] ?? JSON.unknow
                case .object(_): return json[path.stringValue] ?? JSON.unknow
                default:
                    debugPrint("PowerJSONDecoder.startPaths must be container([] or [:]) nested")
                    fatalError()
                }
            } ?? json
            return try inner.unbox(json: used, type: type)
        } catch {
            throw error
        }
    }
}

final class InnerDecoder: Decoder {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey : Any] = [:]
    var json: JSON
    weak var decoder: PowerJSONDecoder?
    
    var keysStore: [[String: [String]]] = []
    var valuesStore: [DecodeValueMappable.Type] = []
    
    var paths: [Path] {
        get { return self.decoder?.paths ?? [] }
        set { self.decoder?.paths = newValue }
    }
    
    init(json: JSON, at codingPath: [CodingKey] = [], decoder: PowerJSONDecoder) {
        self.codingPath = codingPath
        self.json = json
        self.decoder = decoder
    }
}

extension InnerDecoder {
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try self.container(keyedBy: type, json: self.json)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try self.unkeyedContainer(json: self.json)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return DecodeSingleValue(inner: self, json: self.json)
    }
}

extension InnerDecoder {
    func container<Key>(keyedBy type: Key.Type, json: JSON) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        guard case let .object(object) = json else {
            throw Coding.Exception.typeMismatch(type: [String: JSON].self, codingPath: self.codingPath, reality: json)
        }
        let container = DecodeKeyed<Key>(inner: self, json: object)
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer(json: JSON) throws -> UnkeyedDecodingContainer {
        guard case let .array(array) = json else {
            throw Coding.Exception.typeMismatch(type: [JSON].self, codingPath: self.codingPath, reality: json)
        }
        return DecodeUnkeyed(inner: self, json: array)
    }
}

extension InnerDecoder: DecodeValueMappable {}

// MARK: -  空(nil)处理
extension InnerDecoder {
    /// 是否解码空
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Returns: 是否为空
    func unboxNil(json: JSON, forKey key: CodingKey) -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return unboxNil(json: json)
    }
    
    /// 是否解码空
    /// - Parameter json: JSON对象
    /// - Returns: 是否为空
    func unboxNil(json: JSON) -> Bool {
        switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
        case .useDefaultValues:
            return json == .null
        case .useCustomValues(delegete: _):
            if (self.decoder?.strategy.value.enableEmpty ?? false) && json == .null {
                return false
            } else {
                return json == .null
            }
        }
    }
}

// MARK: -  Bool处理
extension InnerDecoder {
    /// 布尔型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Bool {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Bool {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toBool(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toBool(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toBool(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Int处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Int {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Int {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Int8处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Int8 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Int8 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Int16处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Int16 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Int16 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Int32处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Int32 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Int32 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Int64处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Int64 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Int64 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  UInt处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> UInt {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> UInt {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  UInt8处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> UInt8 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> UInt8 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt8(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  UInt16处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> UInt16 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> UInt16 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt16(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  UInt32处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> UInt32 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> UInt32 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt32(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  UInt64处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> UInt64 {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> UInt64 {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toUInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toUInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toUInt64(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  String处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> String {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> String {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toString(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toString(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toString(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Float处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Float {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Float {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toFloat(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toFloat(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toFloat(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  Double处理
extension InnerDecoder {
    /// 字符串型解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox(json: JSON, forKey key: CodingKey) throws -> Double {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json)
    }
    
    func unbox(json: JSON) throws -> Double {
        if self.valuesStore.count >= 1 {
            let type: DecodeValueMappable.Type = self.valuesStore.last!
            return try type.toDouble(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
        } else {
            switch self.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues:
                return try Self.self.toDouble(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            case .useCustomValues(delegete: let delegate):
                return try type(of: delegate).toDouble(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths, json: json)
            }
        }
    }
}

// MARK: -  范型T处理
extension InnerDecoder {
    /// 解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - key: 解码key
    ///   - type: 解码类型
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(json: JSON, forKey key: CodingKey, type: T.Type) throws -> T where T: Decodable {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        return try unbox(json: json, type: type)
    }
    
    /// 解码处理
    /// - Parameters:
    ///   - json: JSON对象
    ///   - type: 解码类型
    /// - Throws: 处理异常
    /// - Returns: 返回处理后的模型
    func unbox<T>(json: JSON, type: T.Type) throws -> T where T: Decodable {
        self.json = json
        print(Swift.type(of: T.self))
        if let value: DecodeKeyMappable.Type = type as? DecodeKeyMappable.Type {
            if type.array() {
                print("Warnning: \(type) unsupport DecodeKeyMappable")
            } else {
                self.keysStore.append(value.modelDecodeKeys(decoder: self.decoder ?? PowerJSONDecoder(), paths: self.paths))
            }
        }
        if let type: DecodeValueMappable.Type = type as? DecodeValueMappable.Type {
            self.valuesStore.append(type)
        }
        if T.self == URL.self || T.self == Date.self || T.self == Data.self {
            let container = DecodeSingleValue(inner: self, json: self.json)
            return try container.decode(T.self)
        }
        defer {
            if self.keysStore.count > 0 {
                if type.array() {
                    self.keysStore.removeLast()
                }
            }
            if self.valuesStore.count > 0 {
                self.valuesStore.removeLast()
            }
        }
        return try T.init(from: self)
    }
}
