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
    var mapping:  [String: String] = [:]

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
        if let value: MappingEncodingKeysValues = encoder.value as? MappingEncodingKeysValues {
            self.mapping = type(of: value).modelEncodingKeys()
        }
    }
}

extension EncodingKeyed {
    mutating func encodeNil(forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
            try container.encodeNil()
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encodeNil()
        }
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
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
        if self.mapping.keys.contains(key.stringValue) {
            self.encoder.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.encoder.paths.pop() }
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container)
            try container.encode(value)
        } else {
            self.encoder.paths.push(value: Path.index(by: key.stringValue))
            defer { self.encoder.paths.pop() }
            self.storage.append(key: key.stringValue, value: container)
            try container.encode(value)
        }
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        if value is URL {
            guard let url = value as? URL else { throw CodingError.invalidTypeTransform() }
            if self.mapping.keys.contains(key.stringValue) {
                let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths + [Path.index(by:  self.mapping[key.stringValue] ?? "")])
                encoder.wrapper = self.encoder.wrapper
                try url.absoluteString.encode(to: encoder)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: encoder.container.jsonValue)
            } else {
                let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                encoder.wrapper = self.encoder.wrapper
                try url.absoluteString.encode(to: encoder)
                self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
            }
        } else {
            if self.mapping.keys.contains(key.stringValue) {
                let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths + [Path.index(by:  self.mapping[key.stringValue] ?? "")])
                encoder.wrapper = self.encoder.wrapper
                try value.encode(to: encoder)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: encoder.container.jsonValue)
            } else {
                let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths + [Path.index(by: key.stringValue)])
                encoder.wrapper = self.encoder.wrapper
                try value.encode(to: encoder)
                self.storage.append(key: key.stringValue, value: encoder.container.jsonValue)
            }
        }
    }

    mutating func encodeIfPresent(_ value: Bool?, forKey key: Key) throws {
        guard let value: Bool = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        guard let value: Int = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int8?, forKey key: Key) throws {
        guard let value: Int8 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int16?, forKey key: Key) throws {
        guard let value: Int16 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int32?, forKey key: Key) throws {
        guard let value: Int32 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int64?, forKey key: Key) throws {
        guard let value: Int64 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt?, forKey key: Key) throws {
        guard let value: UInt = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws {
        guard let value: UInt8 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws {
        guard let value: UInt16 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws {
        guard let value: UInt32 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws {
        guard let value: UInt64 = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Float?, forKey key: Key) throws {
        guard let value: Float = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Double?, forKey key: Key) throws {
        guard let value: Double = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        guard let value: String = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T : Encodable {
        guard let value: T = value else {
            try self.encodeNil(forKey: key); return
        }
        try self.encode(value, forKey: key)
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
