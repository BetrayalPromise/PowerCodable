import Foundation

class EncodeUnkeyed: UnkeyedEncodingContainer {
    private var storage: [JSONValue] = []
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]

    var count: Int {
        return self.storage.count
    }

    var currentIndex: Int = 0

    var nestedCodingPath: [CodingKey] {
        return self.codingPath + [Path(intValue: self.count)!]
    }
    private unowned let inner: InnerEncoder
    var json: [JSON] = []

    init(inner: InnerEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.inner = inner
        self.codingPath = codingPath
        self.userInfo = userInfo
        self.storage.removeAll()
    }

    deinit {
        //debugPrint(self.jsonValue)
    }
}

extension EncodeUnkeyed {
    var paths: [Path] {
        get { return self.inner.encoder?.paths ?? [] }
        set { self.inner.encoder?.paths = newValue }
    }
}

extension EncodeUnkeyed {
    func encodeNil() throws {
        var container = self.nestedSingleValueContainer()
        try container.encodeNil()
    }

    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let container = EncodeUnkeyed(inner: self.inner, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return container
    }

    private func nestedSingleValueContainer() -> SingleValueEncodingContainer {
        let container = EncodeSingleValue(inner: self.inner, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return container
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = EncodeKeyed<NestedKey>(inner: self.inner, codingPath: self.nestedCodingPath, userInfo: self.userInfo)
        self.storage.append(container)
        return KeyedEncodingContainer(container)
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        defer {
            self.currentIndex += 1
        }
        if value is URL {
            self.paths.push(value: Path.index(by: self.currentIndex), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            let value = try self.url(value: value)
            let encoder = InnerEncoder(value: value)
            encoder.encoder = self.inner.encoder
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        } else if value is Date {
            self.paths.push(value: Path.index(by: self.currentIndex), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            let value = try self.date(value: value)
            let encoder = InnerEncoder(value: value)
            encoder.encoder = self.inner.encoder
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        } else {
            self.paths.push(value: Path.index(by: self.currentIndex), encoder: self.inner.encoder ?? PowerJSONEncoder())
            defer { self.paths.pop() }
            debugPrint(self.paths.path)
            let encoder = InnerEncoder(value: value)
            encoder.encoder = self.inner.encoder
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        }
    }

    func superEncoder() -> Encoder {
        fatalError("Unimplemented")
    }
}

extension EncodeUnkeyed {
    func url(value: Encodable) throws -> Encodable {
        guard let url = value as? URL else { throw Coding.Exception.transform() }
        return url.absoluteString
    }
}

extension EncodeUnkeyed {
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

extension EncodeUnkeyed: JSONValue {
    var jsonValue: JSON {
        let elements: [JSON] = self.storage.map {
            return $0.jsonValue
        }
        return .array(elements)
    }
}
