import Foundation

public struct EncodingStrategy {
    public var outputStrategy: PowerJSONEncoder.OutputFormatting = []
    public var keyFormatStrategy: PowerJSONEncoder.KeyFormatEncodingStrategy = .useDefaultKeys
    public var dateValueStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var dataValueStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var nonConformingFloatValueStrategy: PowerJSONEncoder.NonConformingFloatEncodingStrategy = .convertToString()
    public var valueStrategy: PowerJSONEncoder.ValueEncodingStrategy = .useDefaultValues
}

public class PowerJSONEncoder {
    public var strategy = EncodingStrategy()
    var paths: [Path] = []

    /// 逆向模型转化
    /// - Parameters:
    ///   - value: 实现Encodable对象
    ///   - outputType: 输出类型, 只支持[Data String JSONWrapper(json结构) JSON]
    /// - Throws: 解析异常
    /// - Returns: 输出值
    public func encode<T, U>(value: T, to: U.Type) throws -> U.Wrapper where T: Encodable, U: CodingSupport {
        let inner = InnerEncoder(value: value)
        inner.encoder = self
        var json: JSON = .unknow
        if value is JSON {
            json = (value as? JSON) ?? .unknow
        } else {
            try value.encode(to: inner)
            json = inner.jsonValue
        }
        let options = Formatter.Options(formatting: self.strategy.outputStrategy, dataEncoding: self.strategy.dataValueStrategy, dateEncoding: self.strategy.dateValueStrategy, keyEncoding: self.strategy.keyFormatStrategy)
        let formatter = Formatter(topLevel: json, options: options, encoder: inner)
        let data: Data = try formatter.writeJSON()
        if to.Wrapper == Data.self {
            return data as! U.Wrapper
        } else if to.Wrapper == String.self {
            return (String(data: data, encoding: String.Encoding.utf8) ?? "error") as! U.Wrapper
        } else if to.Wrapper == Any.self {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! U.Wrapper
        } else if to.Wrapper == JSON.self {
            return json as! U.Wrapper
        } else {
            throw Coding.Exception.invalidTransform()
        }
    }
}

protocol JSONValue {
    var jsonValue: JSON { get }
}

struct DefaultJSONValue: JSONValue {
    var jsonValue: JSON { return .unknow }
}

extension JSON: JSONValue {
    var jsonValue: JSON {
        return self
    }
}

class InnerEncoder: Encoder {
    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]
    var container: JSONValue = DefaultJSONValue()
    var paths: [Path] {
        get { return self.encoder?.paths ?? [] }
        set { self.encoder?.paths = newValue }
    }
    let value: Encodable
    weak var encoder: PowerJSONEncoder?
    
    var strategy: EncodingStrategy {
        return self.encoder?.strategy ?? EncodingStrategy()
    }

    init(value: Encodable) {
        self.value = value
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let container = EncodeKeyed<Key>(inner: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let container = EncodeUnkeyed(inner: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        let container = EncodeSingleValue(inner: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }
}

extension InnerEncoder: EncodingValueMappable {}

extension InnerEncoder: JSONValue {
    var jsonValue: JSON {
        return self.container.jsonValue
    }
}
