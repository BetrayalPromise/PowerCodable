import Foundation

public class PowerJSONEncoder {
    public var dataEncodingStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var dateEncodingStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var keyEncodingStrategy: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var outputFormatting: PowerJSONEncoder.OutputFormatting = []

    /// 逆向模型转化
    /// - Parameters:
    ///   - value: 实现Encodable对象
    ///   - outputType: 输出类型, 只支持[Data String JSONStructure(json结构)]
    /// - Throws: 解析异常
    /// - Returns: 输出值
    func encode<T, U>(value: T, to: U.Type) throws -> U.Wrapper where T: Encodable, U: JSONCodingSupport {
        let encoder = PowerInnerJSONEncoder(value: value, paths: [])
        try value.encode(to: encoder)
        let json = encoder.jsonValue
        let options = Formatter.Options(formatting: self.outputFormatting, dataEncoding: self.dataEncodingStrategy, dateEncoding: self.dateEncodingStrategy, keyEncoding: self.keyEncodingStrategy)
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
            throw CodingError.unsupportType()
        }
    }
}

protocol JSONValue {
    var jsonValue: JSON { get }
}

struct DefaultJSONValue: JSONValue {
    var jsonValue: JSON { return .null }
}

extension JSON: JSONValue {
    var jsonValue: JSON {
        return self
    }
}

class PowerInnerJSONEncoder: Encoder {
    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]
    var container: JSONValue = DefaultJSONValue()
    var paths: [Path] = []
    let value: Encodable
    var mappingKeys: [String: String]?

    init(value: Encodable, paths: [Path]) {
        self.value = value
        self.paths = paths
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
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

extension PowerInnerJSONEncoder: TypeConvertible {}

extension PowerInnerJSONEncoder: JSONValue {
    var jsonValue: JSON {
        return self.container.jsonValue
    }
}
