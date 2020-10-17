import Foundation

struct EncodingUnkeyed: UnkeyedEncodingContainer {
    private static var storage: [JSONValue] = []
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]

    var count: Int {
        return EncodingUnkeyed.storage.count
    }

    var nestedCodingPath: [CodingKey] {
        return self.codingPath + [PowerJSONKey(intValue: self.count)!]
    }
    private unowned let encoder: PowerInnerJSONEncoder
    var unkeyed: [JSON] = []

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
        EncodingUnkeyed.storage.removeAll()
    }

    mutating func encodeNil() throws {
        var container = self.nestedSingleValueContainer()
        try container.encodeNil()
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let container = EncodingUnkeyed(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        EncodingUnkeyed.storage.append(container)
        return container
    }

    private mutating func nestedSingleValueContainer() -> SingleValueEncodingContainer {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        EncodingUnkeyed.storage.append(container)
        return container
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = EncodingKeyed<NestedKey>(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        EncodingUnkeyed.storage.append(container)
        return KeyedEncodingContainer(container)
    }

    mutating func encode<T>(_ value: T) throws where T : Encodable {
        let encoder = PowerInnerJSONEncoder(value: value)
        try value.encode(to: encoder)
        EncodingUnkeyed.storage.append(encoder)
    }

    func superEncoder() -> Encoder {
        fatalError("Unimplemented")
    }
}

extension EncodingUnkeyed: JSONValue {
    var jsonValue: JSON {
        let elements: [JSON] = EncodingUnkeyed.storage.map {
            return $0.jsonValue
        }
        return .array(elements)
    }
}
