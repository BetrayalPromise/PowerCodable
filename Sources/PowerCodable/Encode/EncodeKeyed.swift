import Foundation

fileprivate class Storage<Key: CodingKey> {
    typealias KeyValue = (String, JSONValue)
    private(set) var elements: [KeyValue] = []
    private var hash: [String: KeyValue] = [:]

    func append(key: String, value: JSONValue, inner: InnerEncoder) {
        var mappingKey: String = ""
        switch inner.strategy.keyFormatStrategy {
        case .useDefaultKeys:
            mappingKey = key
        case .useCamelKeys(let c):
            mappingKey = key.toCamelCase(format: c)
        case .useSnakeKeys(let c):
            mappingKey = key.toSnakeCase(format: c)
        case .usePascalKeys(let c):
            mappingKey = key.toPascalCase(format: c)
        case .useUpperKeys:
            mappingKey = key.toUpperCase()
        case .useLowerKeys:
            mappingKey = key.toLowerCase()
        case .useCustom(let closure):
            mappingKey = closure(inner.paths).stringValue
        }

        let keyValue: KeyValue = (mappingKey, value)
        self.elements.append(keyValue)
        self.hash[key] = keyValue
    }
}

struct EncodeKeyed<Key: CodingKey>: KeyedEncodingContainerProtocol {
    private(set) var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    private var storage = Storage<Key>()
    private unowned let inner: InnerEncoder
    var mapping:  [String: String] = [:]

    init(inner: InnerEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.inner = inner
        self.codingPath = codingPath
        self.userInfo = userInfo
        if let value: EncodeKeyMappable = inner.value as? EncodeKeyMappable {
            self.mapping = type(of: value).modelEncodeKeys(decoder: self.inner.encoder ?? PowerJSONEncoder(), paths: self.paths)
        }
    }
}

extension EncodeKeyed {
    var paths: [Path] {
        get { return self.inner.encoder?.paths ?? [] }
        set { self.inner.encoder?.paths = newValue }
    }
}

extension EncodeKeyed {
    mutating func encodeNil(forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encodeNil()
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encodeNil()
        }
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by:  self.mapping[key.stringValue] ?? ""))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: container, inner: self.inner)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue))
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key.stringValue, value: container, inner: self.inner)
            try container.encode(value)
        }
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        if value is URL {
            let value = try self.url(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: inner.container.jsonValue, inner: self.inner)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key.stringValue, value: inner.container.jsonValue, inner: self.inner)
            }
        } else if value is Data {
            let value = try self.data(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: inner.container.jsonValue, inner: self.inner)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key.stringValue, value: inner.container.jsonValue, inner: self.inner)
            }
        } else if value is Date {
            let value: Encodable = try self.date(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: inner.container.jsonValue, inner: self.inner)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key.stringValue, value: inner.container.jsonValue, inner: self.inner)
            }
        } else {
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key:  self.mapping[key.stringValue] ?? "", value: inner.container.jsonValue, inner: self.inner)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue))
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key.stringValue, value: inner.container.jsonValue, inner: self.inner)
            }
        }
    }

    mutating func encodeIfPresent(_ value: Bool?, forKey key: Key) throws {
        guard let value: Bool = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        guard let value: Int = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int8?, forKey key: Key) throws {
        guard let value: Int8 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int16?, forKey key: Key) throws {
        guard let value: Int16 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int32?, forKey key: Key) throws {
        guard let value: Int32 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Int64?, forKey key: Key) throws {
        guard let value: Int64 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt?, forKey key: Key) throws {
        guard let value: UInt = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws {
        guard let value: UInt8 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws {
        guard let value: UInt16 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws {
        guard let value: UInt32 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws {
        guard let value: UInt64 = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Float?, forKey key: Key) throws {
        guard let value: Float = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: Double?, forKey key: Key) throws {
        guard let value: Double = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        guard let value: String = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T : Encodable {
        guard let value: T = value else { try self.encodeNil(forKey: key); return }
        try self.encode(value, forKey: key)
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = EncodeKeyed<NestedKey>(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        self.storage.append(key: key.stringValue, value: container, inner: self.inner)
        return KeyedEncodingContainer(container)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let container = EncodeUnkeyed(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        self.storage.append(key: key.stringValue, value: container, inner: self.inner)
        return container
    }

    mutating func superEncoder() -> Encoder {
        fatalError("Unimplemented yet")
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        fatalError("Unimplemented yet")
    }
}

extension EncodeKeyed {
    func url(value: Encodable) throws -> Encodable {
        guard let url = value as? URL else { throw Coding.Exception.invalidTransform() }
        return url.absoluteString
    }
}

extension EncodeKeyed {
    func data(value: Encodable) throws -> Encodable {
        guard let mapping = value as? Data else { throw Coding.Exception.invalidTransform() }
        switch self.inner.encoder?.strategy.dataValueStrategy ?? .base64 {
        case .deferredToData, .hexadecimalArray: return value
        case .base64: return mapping.base64EncodedString()
        case .custom(let closure): return try closure(mapping, self.inner)
        }
    }
}

extension EncodeKeyed {
    func date(value: Encodable) throws -> Encodable {
        guard let value: Date = value as? Date else { throw Coding.Exception.invalidTransform() }
        var mapping: Encodable = ""
        switch self.inner.encoder?.strategy.dateValueStrategy ?? .utc {
        case .deferredToDate, .utc:
            mapping = DateFormatter.utc().string(from: value)
        case .iso8601:
            mapping = DateFormatter.iso8601().string(from: value)
        case .secondsSince1970(let form):
            switch form {
            case .number: mapping = value.timeIntervalSince1970
            case .string: mapping = "\(value.timeIntervalSince1970)"
            }
        case .millisecondsSince1970(let form):
            switch form {
            case .number: mapping = value.timeIntervalSince1970 * 1000
            case .string: mapping = "\(value.timeIntervalSince1970 * 1000)"
            }
        case .formatted(let formatter): mapping = formatter.string(from: value)
        case .custom(let closure): mapping = try closure(value, self.inner)
        }
        return mapping
    }
}

extension EncodeKeyed: JSONValue {
    var jsonValue: JSON {
        let elements: [String: JSON] = self.storage.elements.map {
            return ($0.0, $0.1.jsonValue)
        }.toPowerObject()
        return .object(elements)
    }
}
