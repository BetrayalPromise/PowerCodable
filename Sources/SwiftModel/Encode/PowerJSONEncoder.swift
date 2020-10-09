import Foundation

public class PowerJSONEncoder {
    enum EncodingError: Error {
        case invalidUTF8String(String)
    }

    public var dataEncodingStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var dateEncodingStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var keyEncodingStrategy: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var outputFormatting: PowerJSONEncoder.OutputFormatting = []

    /// 逆向模型转化
    /// - Parameter value: 实现Encodable对象
    /// - Throws: 解析异常
    /// - Returns: 转换完成的二进制数据
    func encodeToData<T>(value: T) throws -> Data where T: Encodable {
        let encoder = PowerInnerJSONEncoder()
        try value.encode(to: encoder)
        let topLevel = encoder.jsonValue
        let options = Formatter.Options(formatting: self.outputFormatting, dataEncoding: self.dataEncodingStrategy, dateEncoding: self.dateEncodingStrategy, keyEncoding: self.keyEncodingStrategy)
        let formatter = Formatter(topLevel: topLevel, options: options, encoder: encoder)
        return try formatter.writeJSON()
    }

    /// 逆向模型转化
    /// - Parameter value: 实现Encodable对象
    /// - Throws: 解析异常
    /// - Returns: 转换完成的字符串数据
    func encodeToString<T>(value: T) throws -> String where T: Encodable {
        return String(data: try self.encodeToData(value: value), encoding: String.Encoding.utf8) ?? "error"
    }

    /// 逆向模型转化
    /// - Parameter value: 实现Encodable对象
    /// - Throws: 解析异常
    /// - Returns: 转换完成的JSON对象
    func encodeToJSONObject<T>(value: T) throws -> Any where T: Encodable {
        return try JSONSerialization.jsonObject(with: try self.encodeToData(value: value), options: JSONSerialization.ReadingOptions.mutableLeaves)
    }
}

protocol JSONValue {
    var jsonValue: JSON { get }
}

class PowerInnerJSONEncoder: Encoder {
    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]
    fileprivate var container: JSONValue?

    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()
        let container = EncodingKeyed<Key>(referencing: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()
        let container = EncodingUnkeyed(referencing: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        let container = EncodingSingleValue(referencing: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }
}

extension PowerInnerJSONEncoder: JSONValue {
    var jsonValue: JSON {
        return container?.jsonValue ?? .null
    }
}
