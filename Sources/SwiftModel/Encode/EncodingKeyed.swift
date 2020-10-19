import Foundation

fileprivate class Storage<Key: CodingKey> {
    typealias KeyValue = (String, JSONValue)
    private(set) var elements: [KeyValue] = []
    private var hash: [String: KeyValue] = [:]

    func append(key: String, value: JSONValue) {
        let keyValue: KeyValue = (key, value)
        self.elements.append(keyValue)
        self.hash[key] = keyValue
    }
}

struct EncodingKeyed<Key: CodingKey>: KeyedEncodingContainerProtocol {
    private(set) var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    private var storage = Storage<Key>()
    private unowned let encoder: PowerInnerJSONEncoder

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
    }
}

extension EncodingKeyed {
    mutating func encodeNil(forKey key: Key) throws {
        print("key: \(key.stringValue)")
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            /// 没有实现自定义key转化
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
            return
        }
        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
        let mapping = type(of: keyValue).modelEncodingKeys()
        if mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        let keyValue: MappingEncodingKeysValues? = self.encoder.value as? MappingEncodingKeysValues
        if value is URL {
            guard let url = value as? URL else { throw CodingError.invalidTypeTransform() }
            if keyValue.isHasValue {
                let mapping: [String: String] = type(of: keyValue!).modelEncodingKeys()
                if mapping.keys.contains(key.stringValue) {
                    let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths + [Path.index(by: mapping[key.stringValue] ?? "")])
                    try url.absoluteString.encode(to: encoder)
                    self.storage.append(key: mapping[key.stringValue] ?? "", value: encoder.container.jsonValue)
                } else {
                    let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                    try url.absoluteString.encode(to: encoder)
                    self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
                }
            } else {
                let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                try url.absoluteString.encode(to: encoder)
                self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
            }
        } else {
            if keyValue.isHasValue {
                let mapping: [String: String] = type(of: keyValue!).modelEncodingKeys()
                if mapping.keys.contains(key.stringValue) {
                    let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths + [Path.index(by: mapping[key.stringValue] ?? "")])
                    try value.encode(to: encoder)
                    self.storage.append(key: mapping[key.stringValue] ?? "", value: encoder.container.jsonValue)
                } else {
                    let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                    try value.encode(to: encoder)
                    self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
                }
            } else {
                let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                try value.encode(to: encoder)
                self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
            }
        }
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = EncodingKeyed<NestedKey>(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        self.storage.append(key: key.stringValue, value: container)
        return KeyedEncodingContainer(container)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let container = EncodingUnkeyed(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        self.storage.append(key: key.stringValue, value: container)
        return container
    }

    mutating func superEncoder() -> Encoder {
        fatalError("Unimplemented yet")
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        fatalError("Unimplemented yet")
    }
}

extension EncodingKeyed: JSONValue {
    var jsonValue: JSON {
        let elements: [String: JSON] = self.storage.elements.map {
            return ($0.0, $0.1.jsonValue)
        }.toJSONObject()
        return .object(elements)
    }
}
