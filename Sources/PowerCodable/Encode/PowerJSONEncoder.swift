import Foundation

public struct EncodingStrategy {
    public var output: PowerJSONEncoder.OutputFormatting = []
    public var keyMapping: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var dateValueMapping: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var dataValueMapping: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var nonConformingFloatValueMapping: PowerJSONEncoder.NonConformingFloatEncodingStrategy = .convertToString()
    public var valueMapping: PowerJSONEncoder.ValueEncodingStrategy = .useDefaultValues
}

public class PowerJSONEncoder {
    public var strategy = EncodingStrategy()
    public var paths: [Path] = []

    /// 逆向模型转化
    /// - Parameters:
    ///   - value: 实现Encodable对象
    ///   - outputType: 输出类型, 只支持[Data String JSONWrapper(json结构) JSON]
    /// - Throws: 解析异常
    /// - Returns: 输出值
    func encode<T, U>(value: T, to: U.Type) throws -> U.Wrapper where T: Encodable, U: CodingSupport {
        let encoder = InnerEncoder(value: value)
        encoder.wrapper = self
        var json: JSON = .unknow
        if value is JSON {
            json = (value as? JSON) ?? .unknow
        } else {
            try value.encode(to: encoder)
            json = encoder.jsonValue
        }
        let options = Formatter.Options(formatting: self.strategy.output, dataEncoding: self.strategy.dataValueMapping, dateEncoding: self.strategy.dateValueMapping, keyEncoding: self.strategy.keyMapping)
        let formatter = Formatter(topLevel: json, options: options, encoder: encoder)
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
        get { return self.wrapper?.paths ?? [] }
        set { self.wrapper?.paths = newValue }
    }
    let value: Encodable
    unowned var wrapper: PowerJSONEncoder?
    
    var strategy: EncodingStrategy {
        return self.wrapper?.strategy ?? EncodingStrategy()
    }

    init(value: Encodable) {
        self.value = value
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let container = EncodingKeyed<Key>(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let container = EncodingUnkeyed(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        let container = EncodingSingleValue(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
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
