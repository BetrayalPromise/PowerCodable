import Foundation

class DecodingKeyed<K: CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K
    private unowned let decoder: PowerInnerJSONDecoder
    private let json: [String: JSON]
    
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }
    
    init(decoder: PowerInnerJSONDecoder,  json: [String: JSON]) {
        self.decoder  = decoder
        self.json = json
    }
    
    var allKeys: [Key] {
        return self.json.keys.compactMap(Key.init)
    }
    
    func contains(_ key: Key) -> Bool {
        return self.json[key.stringValue] != nil
    }

    @inline(__always)
    private func getObject(forKey key: Key) throws -> JSON {
        var mappingKey: String = ""
        switch self.decoder.wrapper?.strategy.keysMapping ?? .useDefaultKeys {
        case .useDefaultKeys:
            mappingKey = key.stringValue
        case .useCamelKeys(let c):
            mappingKey = key.stringValue.toCamelCase(format: c)
        case .useSnakeKeys(let c):
            mappingKey = key.stringValue.toSnakeCase(format: c)
        case .usePascalKeys(let c):
            mappingKey = key.stringValue.toPascalCase(format: c)
        case .useUpperKeys:
            mappingKey = key.stringValue.toUpperCase()
        case .useLowerKeys:
            mappingKey = key.stringValue.toLowerCase()
        }
        guard let object = self.json[mappingKey] else {
            if self.json.count == 0 {
                return JSON(dictionaryLiteral: ("", ""))
            } else {
                if self.decoder.mappingKeys != nil {
                    for k in self.decoder.mappingKeys?[key.stringValue] ?? [] {
                        switch self.json[k] {
                        case .none: continue
                        case .some(let json): return json
                        }
                    }
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please implement MappingDecodingKeys")
                    return JSON(dictionaryLiteral: ("", ""))
                } else {
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please implement MappingDecodingKeys")
                    return JSON(dictionaryLiteral: ("", ""))
                }
            }
        }
        return object
    }
}

extension DecodingKeyed {
    var paths: [Path] {
        get { return self.decoder.wrapper?.paths ?? [] }
        set { self.decoder.wrapper?.paths = newValue }
    }
}

extension DecodingKeyed {
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unboxNil(object: getObject(forKey: key), forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        self.paths.push(value: Path.index(by: key.stringValue))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unboxDecodable(object: getObject(forKey: key), forKey: key)
    }
}

extension DecodingKeyed {
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
        return try buildSuperDecoder(forKey: PowerJSONKey.super)
    }

    func superDecoder(forKey key: K) throws -> Decoder {
        return try buildSuperDecoder(forKey: key)
    }
}

extension DecodingKeyed {
    private func buildSuperDecoder(forKey key: CodingKey) throws -> Decoder {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let value = (key is PowerJSONKey) == true ? JSON.object(self.json) : self.json[key.stringValue, default: .null]
        return PowerInnerJSONDecoder(json: value, at: decoder.codingPath)
    }
}
