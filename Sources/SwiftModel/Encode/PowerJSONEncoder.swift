import Foundation

public class PowerJSONEncoder {
//    enum EncodingError: Error {
//        case invalidUTF8String(String)
//    }

    public var dataEncodingStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var dateEncodingStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var keyEncodingStrategy: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var outputFormatting: PowerJSONEncoder.OutputFormatting = []

    /// 逆向模型转化
    /// - Parameters:
    ///   - value: 实现Encodable对象
    ///   - outputType: 输出类型, 只支持[Data String Any(json结构)]
    /// - Throws: 解析异常
    /// - Returns: 输出值
    func encode<T, U>(value: T, outputType: U.Type) throws -> U where T: Encodable {
        let encoder = PowerInnerJSONEncoder(value: value)
        try value.encode(to: encoder)
        let topLevel = encoder.jsonValue
        let options = Formatter.Options(formatting: self.outputFormatting, dataEncoding: self.dataEncodingStrategy, dateEncoding: self.dateEncodingStrategy, keyEncoding: self.keyEncodingStrategy)
        let formatter = Formatter(topLevel: topLevel, options: options, encoder: encoder)
        let data = try formatter.writeJSON()
        if outputType == Data.self {
            return data as! U
        } else if outputType == String.self {
            return (String(data: data, encoding: String.Encoding.utf8) ?? "error") as! U
        } else if outputType == Any.self {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! U
        } else {
            throw CodingError.unsupportType()
        }
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
    var paths: [Path] = []
    var value: Encodable
    var mappingKeys: [String: String]?

    init(value: Encodable) {
        self.value = value
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()
        print(#function, "begin")
        defer { print(#function, "end") }
        let container = EncodingKeyed<Key>(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()
        print(#function, "begin")
        defer { print(#function, "end") }
        let container = EncodingUnkeyed(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        print(#function, "begin")
        defer { print(#function, "end") }
        let container = EncodingSingleValue(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }
}

extension PowerInnerJSONEncoder: TypeConvertible {}

extension PowerInnerJSONEncoder: JSONValue {
    var jsonValue: JSON {
        return container?.jsonValue ?? .null
    }
}
