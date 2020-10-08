import Foundation

extension PowerInnerJSONEncoder {
    class UnkeyedContainer: UnkeyedEncodingContainer {

        struct Index: CodingKey {
            var intValue: Int?

            var stringValue: String {
                return "\(self.intValue!)"
            }

            init?(intValue: Int) {
                self.intValue = intValue
            }

            init?(stringValue: String) {
                return nil
            }
        }
        private var storage: [JSONValue] = []

        var codingPath: [CodingKey]

        var userInfo: [CodingUserInfoKey: Any]

        var count: Int {
            return self.storage.count
        }

        var nestedCodingPath: [CodingKey] {
            return self.codingPath + [Index(intValue: self.count)!]
        }

        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
        }

        // MARK: - UnkeyedEncodingContainer
        func encodeNil() throws {
            var container = self.nestedSingleValueContainer()
            try container.encodeNil()
        }

        func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
            let container = UnkeyedContainer(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
            self.storage.append(container)
            return container
        }

        private func nestedSingleValueContainer() -> SingleValueEncodingContainer {
            let container = PowerInnerJSONEncoder.SingleValueContainer(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
            self.storage.append(container)
            return container
        }

        func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            let container = PowerInnerJSONEncoder.KeyedContainer<NestedKey>(codingPath: self.nestedCodingPath, userInfo: self.userInfo)
            self.storage.append(container)

            return KeyedEncodingContainer(container)
        }
        
        func encode<T>(_ value: T) throws where T : Encodable {
            var container = self.nestedSingleValueContainer()
            try container.encode(value)
        }

        func superEncoder() -> Encoder {
            fatalError("Unimplemented")
        }
    }
}

extension PowerInnerJSONEncoder.UnkeyedContainer: JSONValue {
    var jsonValue: JSON {
        let elements = self.storage.map { $0.jsonValue }
        return .array(elements)
    }
}
