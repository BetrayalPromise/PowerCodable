import Foundation

class DecodeKeyed<K: CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K
    private unowned let decoder: InnerDecoder
    private let json: [String: JSON]
    
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }
    
    init(decoder: InnerDecoder,  json: [String: JSON]) {
        self.decoder  = decoder
        self.json = json
    }
    
    var allKeys: [Key] {
        return self.json.keys.compactMap(Key.init)
    }
    
    func contains(_ key: Key) -> Bool {
        return true
    }

    @inline(__always)
    private func getObject(forKey key: Key) throws -> JSON {
        var useKey: String = ""
        switch self.decoder.wrapper?.strategy.keyMappable ?? .useDefaultKeys {
        case .useDefaultKeys:
            useKey = key.stringValue
        case .useCamelKeys(let c):
            useKey = key.stringValue.toCamelCase(format: c)
        case .useSnakeKeys(let c):
            useKey = key.stringValue.toSnakeCase(format: c)
        case .usePascalKeys(let c):
            useKey = key.stringValue.toPascalCase(format: c)
        case .useUpperKeys:
            useKey = key.stringValue.toUpperCase()
        case .useLowerKeys:
            useKey = key.stringValue.toLowerCase()
        case .useCustom(let closure):
            useKey = closure(self.paths).stringValue
        }
        guard let object = self.json[useKey] else {
            if self.json.count == 0 {
                return JSON(dictionaryLiteral: ("", ""))
            } else {
                if self.decoder.keysStore.last != nil {
                    for k in self.decoder.keysStore.last?[key.stringValue] ?? [] {
                        switch self.json[k] {
                        case .none: continue
                        case .some(let json): return json
                        }
                    }
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please implement DecodeKeysMappable")
                    return JSON(dictionaryLiteral: ("", ""))
                } else {
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please implement DecodeKeysMappable")
                    return JSON(dictionaryLiteral: ("", ""))
                }
            }
        }
        return object
    }
}

extension DecodeKeyed {
    var paths: [Path] {
        get { return self.decoder.wrapper?.paths ?? [] }
        set { self.decoder.wrapper?.paths = newValue }
    }
}

extension DecodeKeyed {
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unboxNil(object: getObject(forKey: key), forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.current)
        return try decoder.unboxDecodable(object: getObject(forKey: key), forKey: key)
    }
}

extension DecodeKeyed {
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        let object = try getObject(forKey: key)
        return try decoder.container(keyedBy: type, wrapping: object)
    }

    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let object = try getObject(forKey: key)
        return try decoder.unkeyedContainer(wrapping: object)
    }

    func superDecoder() throws -> Decoder {
        return try buildSuperDecoder(forKey: Path.super)
    }

    func superDecoder(forKey key: K) throws -> Decoder {
        return try buildSuperDecoder(forKey: key)
    }
}

extension DecodeKeyed {
    private func buildSuperDecoder(forKey key: CodingKey) throws -> Decoder {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let value = (key is Path) == true ? JSON.object(self.json) : self.json[key.stringValue, default: .null]
        return InnerDecoder(json: value, at: decoder.codingPath)
    }
}
