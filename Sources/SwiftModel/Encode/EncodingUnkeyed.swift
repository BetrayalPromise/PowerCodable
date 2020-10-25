import Foundation

class EncodingUnkeyed: UnkeyedEncodingContainer {
    private var storage: [JSONValue] = []
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]

    var count: Int {
        return self.storage.count
    }

    var currentIndex: Int = 0

    var nestedCodingPath: [CodingKey] {
        return self.codingPath + [PowerJSONKey(intValue: self.count)!]
    }
    private unowned let encoder: PowerInnerJSONEncoder
    var unkeyed: [JSON] = []

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
        self.storage.removeAll()
    }

    deinit {
        //print(self.jsonValue)
    }
}

extension EncodingUnkeyed {
    var paths: [Path] {
        get { return self.encoder.wrapper?.paths ?? [] }
        set { self.encoder.wrapper?.paths = newValue }
    }
}

extension EncodingUnkeyed {
    func encodeNil() throws {
        var container = self.nestedSingleValueContainer()
        try container.encodeNil()
    }

    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let container = EncodingUnkeyed(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return container
    }

    private func nestedSingleValueContainer() -> SingleValueEncodingContainer {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return container
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = EncodingKeyed<NestedKey>(encoder: self.encoder, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return KeyedEncodingContainer(container)
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        defer {
            self.currentIndex += 1
        }
        if value is URL {
            self.paths.push(value: Path.index(by: self.currentIndex))
            defer { self.paths.pop() }
            debugPrint(self.paths.jsonPath)
            guard let url = value as? URL else { throw CodingError.invalidTypeTransform() }
            let encoder = PowerInnerJSONEncoder(value: url.absoluteString)
            encoder.wrapper = self.encoder.wrapper
            try url.absoluteString.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        } else {
            self.paths.push(value: Path.index(by: self.currentIndex))
            defer { self.paths.pop() }
            debugPrint(self.paths.jsonPath)
            let encoder = PowerInnerJSONEncoder(value: value)
            encoder.wrapper = self.encoder.wrapper
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        }
    }

    func superEncoder() -> Encoder {
        fatalError("Unimplemented")
    }
}

extension EncodingUnkeyed: JSONValue {
    var jsonValue: JSON {
        let elements: [JSON] = self.storage.map {
            return $0.jsonValue
        }
        return .array(elements)
    }
}
