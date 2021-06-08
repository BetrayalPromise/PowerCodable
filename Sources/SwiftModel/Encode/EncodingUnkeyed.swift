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
        return self.codingPath + [Path(intValue: self.count)!]
    }
    private unowned let encoder: InnerEncoder
    var unkeyed: [JSON] = []

    init(encoder: InnerEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
        self.storage.removeAll()
    }

    deinit {
        //debugPrint(self.jsonValue)
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
            let value = try self.url(value: value)
            let encoder = InnerEncoder(value: value)
            encoder.wrapper = self.encoder.wrapper
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        } else if value is Date {
            self.paths.push(value: Path.index(by: self.currentIndex))
            defer { self.paths.pop() }
            debugPrint(self.paths.jsonPath)
            let value = try self.date(value: value)
            let encoder = InnerEncoder(value: value)
            encoder.wrapper = self.encoder.wrapper
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        } else {
            self.paths.push(value: Path.index(by: self.currentIndex))
            defer { self.paths.pop() }
            debugPrint(self.paths.jsonPath)
            let encoder = InnerEncoder(value: value)
            encoder.wrapper = self.encoder.wrapper
            try value.encode(to: encoder)
            self.storage.append(encoder.container.jsonValue)
        }
    }

    func superEncoder() -> Encoder {
        fatalError("Unimplemented")
    }
}

extension EncodingUnkeyed {
    func url(value: Encodable) throws -> Encodable {
        guard let url = value as? URL else { throw Coding.Exception.invalidTypeTransform() }
        return url.absoluteString
    }
}

extension EncodingUnkeyed {
    func date(value: Encodable) throws -> Encodable {
        guard let value: Date = value as? Date else { throw Coding.Exception.invalidTypeTransform() }
        var mapping: Encodable = ""
        switch self.encoder.wrapper?.strategy.dateValueMapping ?? .utc {
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
        case .custom(let closure): mapping = try closure(value, self.encoder)
        }
        return mapping
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
