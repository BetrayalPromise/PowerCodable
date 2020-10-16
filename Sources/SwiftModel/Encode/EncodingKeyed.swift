import Foundation

fileprivate class Storage<Key: CodingKey> {
//    typealias KeyValue = (Key, JSONValue)
//    private(set) var elements: [KeyValue] = []
//    private var hash: [String: KeyValue] = [:]
//
//    func append(key: Key, value: JSONValue) {
//        let keyValue: KeyValue = (key, value)
//        self.elements.append(keyValue)
//        self.hash[key.stringValue] = keyValue
//    }

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

//    func nestedCodingPath(forKey key: CodingKey) -> [CodingKey] {
//        return self.codingPath + [key]
//    }
//
//    func encodeNil(forKey key: Key) throws {
//        var container = self.nestedSingleValueContainer(forKey: key)
//        try container.encodeNil()
//    }
//
//    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
//        var container = self.nestedSingleValueContainer(forKey: key)
//        try container.encode(value)
//    }
//
//    private func nestedSingleValueContainer(forKey key: Key) -> SingleValueEncodingContainer {
//        let container = EncodingSingleValue(referencing: self.encoder, codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
//        self.storage.append(key: key, value: container)
//        return container
//    }
//
//
//    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
//        let container = EncodingUnkeyed(referencing: self.encoder, codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
//        self.storage.append(key: key, value: container)
//        return container
//    }
//
//    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
//        let container = EncodingKeyed<NestedKey>(referencing: self.encoder, codingPath: self.nestedCodingPath(forKey: key), userInfo: self.userInfo)
//        self.storage.append(key: key, value: container)
//        return KeyedEncodingContainer(container)
//    }
//
//    func superEncoder() -> Encoder {
//        fatalError("Unimplemented yet")
//    }
//
//    func superEncoder(forKey key: Key) -> Encoder {
//        fatalError("Unimplemented yet")
//    }
}

extension EncodingKeyed {
    mutating func encodeNil(forKey key: Key) throws {
        print("key: \(key.stringValue)")
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
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
        let encoder = PowerInnerJSONEncoder(value: value)
        try value.encode(to: encoder)

        self.storage.append(key: key.stringValue, value: encoder.container!)
//        let container = EncodingSingleValue(encoder: self.encoder, codingPath: self.codingPath, userInfo: self.userInfo)
//        guard let keyValue: MappingEncodingKeys = self.encoder.value as? MappingEncodingKeys else {
//            /// 没有实现自定义key转化
//            self.encoder.paths.push(value: Path.index(by: key.stringValue))
//            defer { self.encoder.paths.pop() }
//            self.storage.append(key: key.stringValue, value: container)
//            try container.encode(value)
//            return
//        }
//        self.encoder.mappingKeys = type(of: keyValue).modelEncodingKeys()
//        let mapping = type(of: keyValue).modelEncodingKeys()
//        if mapping.keys.contains(key.stringValue) {
//            self.encoder.paths.push(value: Path.index(by: mapping[key.stringValue] ?? ""))
//            defer { self.encoder.paths.pop() }
//            self.storage.append(key: mapping[key.stringValue] ?? "", value: container)
//            try container.encode(value)
//        } else {
//            self.encoder.paths.push(value: Path.index(by: key.stringValue))
//            defer { self.encoder.paths.pop() }
//            self.storage.append(key: key.stringValue, value: container)
//            try container.encode(value)
//        }
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
