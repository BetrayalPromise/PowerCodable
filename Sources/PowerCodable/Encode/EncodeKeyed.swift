import Foundation

class Storage<Key: CodingKey> {
    typealias KeyValue = (String, JSONValue)
    private(set) var elements: [KeyValue] = []
    private var hash: [String: KeyValue] = [:]
    
    func append(key: CodingKey, value: JSONValue, keyed: EncodeKeyed<Key>) {
        var usedCodingKey: CodingKey = key
        var usedKey = key.stringValue
        if !keyed.mapping.keys.contains(key.stringValue) {
            switch keyed.inner.encoder?.strategy.key.mapping ?? .useDefaultKeys {
            case .useDefaultKeys: break
            case .useCustomKeys(closue: let closure): usedCodingKey = closure(usedCodingKey, keyed.inner.paths)
            }
            switch keyed.inner.encoder?.strategy.key.formatting ?? .useDefaultKeys {
            case .useDefaultKeys: break
            case .useCamelKeys(let c): usedKey = usedKey.toCamelCase(format: c)
            case .useSnakeKeys(let c): usedKey = usedKey.toSnakeCase(format: c)
            case .usePascalKeys(let c): usedKey = usedKey.toPascalCase(format: c)
            case .useUpperKeys: usedKey = usedKey.toUpperCase()
            case .useLowerKeys: usedKey = usedKey.toLowerCase()
            }
        }
        let keyValue: KeyValue = (usedKey, value)
        self.elements.append(keyValue)
        self.hash[usedKey] = keyValue
    }
}

struct EncodeKeyed<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    var storage = Storage<Key>()
    unowned let inner: InnerEncoder
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
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encodeNil()
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encodeNil()
        }
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        if self.mapping.keys.contains(key.stringValue) {
            self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: container, keyed: self)
            try container.encode(value)
        } else {
            self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            self.storage.append(key: key, value: container, keyed: self)
            try container.encode(value)
        }
    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        if value is URL {
            let value = try self.url(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: inner.container.jsonValue, keyed: self)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key, value: inner.container.jsonValue, keyed: self)
            }
        } else if value is Data {
            let value = try self.data(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: inner.container.jsonValue, keyed: self)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key, value: inner.container.jsonValue, keyed: self)
            }
        } else if value is Date {
            let value: Encodable = try self.date(value: value)
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: Path.index(by: self.mapping[key.stringValue] ?? ""), value: inner.container.jsonValue, keyed: self)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key, value: inner.container.jsonValue, keyed: self)
            }
        } else {
            if self.mapping.keys.contains(key.stringValue) {
                self.paths.push(value: Path.index(by: self.mapping[key.stringValue] ?? ""), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key, value: inner.container.jsonValue, keyed: self)
            } else {
                self.paths.push(value: Path.index(by: key.stringValue), encoder: self.inner.encoder ?? PowerJSONEncoder())
                defer { self.paths.pop() }
                debugPrint(self.paths.path)
                let inner = InnerEncoder(value: value)
                inner.encoder = self.inner.encoder
                try value.encode(to: inner)
                self.storage.append(key: key, value: inner.container.jsonValue, keyed: self)
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
        self.storage.append(key: key, value: container, keyed: self)
        return KeyedEncodingContainer(container)
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let container = EncodeUnkeyed(inner: self.inner, codingPath: self.codingPath, userInfo: self.userInfo)
        self.storage.append(key: key, value: container, keyed: self)
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
        guard let url = value as? URL else { throw Coding.Exception.transform() }
        return url.absoluteString
    }
}

extension EncodeKeyed {
    func data(value: Encodable) throws -> Encodable {
        guard let mapping = value as? Data else { throw Coding.Exception.transform() }
        switch self.inner.encoder?.strategy.value.data ?? .base64 {
        case .deferredToData, .hexadecimalArray: return value
        case .base64: return mapping.base64EncodedString()
        case .custom(let closure): return try closure(mapping, self.inner)
        }
    }
}

extension EncodeKeyed {
    func date(value: Encodable) throws -> Encodable {
        guard let value: Date = value as? Date else { throw Coding.Exception.transform() }
        var mapping: Encodable = ""
        switch self.inner.encoder?.strategy.value.date ?? .utc {
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
