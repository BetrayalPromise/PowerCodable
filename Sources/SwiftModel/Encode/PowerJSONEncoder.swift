import Foundation

public class PowerJSONEncoder {
    enum EncodingError: Error {
        case invalidUTF8String(String)
    }

    public var dataEncodingStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var dateEncodingStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var keyEncodingStrategy: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var outputFormatting: PowerJSONEncoder.OutputFormatting = []
    
    func encode<T>(_ value: T) throws -> Data where T: Encodable {
        let encoder = PowerInnerJSONEncoder()
        try value.encode(to: encoder)
        let topLevel = encoder.jsonValue
        let options = Formatter.Options(formatting: self.outputFormatting, dataEncoding: self.dataEncodingStrategy, dateEncoding: self.dateEncodingStrategy, keyEncoding: self.keyEncodingStrategy)
        let formatter = Formatter(topLevel: topLevel, options: options, encoder: encoder)
        return try formatter.writeJSON()
    }
}

protocol JSONValue {
    var jsonValue: JSONType { get }
}

class PowerInnerJSONEncoder: Encoder {
    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]
     fileprivate var container: JSONValue?

    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }

    var jsonValue: JSONType {
        return container?.jsonValue ?? .null
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()

        let container = KeyedContainer<Key>(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container

        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()

        let container = UnkeyedContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container

        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        let container = SingleValueContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }
}
