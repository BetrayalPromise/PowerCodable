import Foundation

extension PowerInnerJSONEncoder {
    fileprivate class Storage<Key: CodingKey> {
        typealias KeyValue = (Key, JSONValue)
        private(set) var elements: [KeyValue] = []
        private var hash: [String: KeyValue] = [:]

        func append(key: Key, value: JSONValue) {
            let keyValue: KeyValue = (key, value)
            self.elements.append(keyValue)
            self.hash[key.stringValue] = keyValue
        }
    }

    class KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
        private(set) var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]

        private var storage = Storage<Key>()

        func nestedCodingPath(forKey key: CodingKey) -> [CodingKey] {
            return self.codingPath + [key]
        }

        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
        }

        // MARK: - KeyedEncodingContainerProtocol
        func encodeNil(forKey key: Key) throws {
            var container = self.nestedSingleValueContainer(forKey: key)
            try container.encodeNil()
        }

        func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
            var container = self.nestedSingleValueContainer(forKey: key)
            try container.encode(value)
        }

        private func nestedSingleValueContainer(forKey key: Key) -> SingleValueEncodingContainer {
            let container = PowerInnerJSONEncoder.SingleValueContainer(codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
            self.storage.append(key: key, value: container)
            return container
        }


         func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
            let container = PowerInnerJSONEncoder.UnkeyedContainer(codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
            self.storage.append(key: key, value: container)

            return container
        }

        func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let container = PowerInnerJSONEncoder.KeyedContainer<NestedKey>(codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
            self.storage.append(key: key, value: container)

            return KeyedEncodingContainer(container)
        }

        func superEncoder() -> Encoder {
            fatalError("Unimplemented yet")
        }

        func superEncoder(forKey key: Key) -> Encoder {
            fatalError("Unimplemented yet")
        }
    }

}

extension PowerInnerJSONEncoder.KeyedContainer: JSONValue {
    var jsonValue: JSONType {
        let elements = self.storage.elements.map { ($0.0.stringValue, $0.1.jsonValue) }
        return .object(elements)
    }
}
