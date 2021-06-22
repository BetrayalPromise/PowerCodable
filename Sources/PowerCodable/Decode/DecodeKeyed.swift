import Foundation

class DecodeKeyed<K: CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K
    private unowned let inner: InnerDecoder
    private let json: [String: JSON]
    
    var type: DecodeKeyMappable.Type?
    
    var codingPath: [CodingKey] {
        get { return self.inner.codingPath }
        set { self.inner.codingPath = newValue }
    }
    
    init(inner: InnerDecoder,  json: [String: JSON]) {
        self.inner  = inner
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
        var usedKey: String = ""
        switch self.inner.decoder?.strategy.key.mapping ?? .useDefaultKeys {
        case .useDefaultKeys: usedKey = key.stringValue
        case .useCustomKeys(closue: let closue): usedKey = closue(key, self.paths).stringValue
        }
        
        switch self.inner.decoder?.strategy.key.formatting ?? .useDefaultKeys {
        case .useDefaultKeys: break
        case .useCamelKeys(let c): usedKey = usedKey.toCamelCase(format: c)
        case .useSnakeKeys(let c): usedKey = usedKey.toSnakeCase(format: c)
        case .usePascalKeys(let c): usedKey = usedKey.toPascalCase(format: c)
        case .useUpperKeys: usedKey = usedKey.toUpperCase()
        case .useLowerKeys: usedKey = usedKey.toLowerCase()
        }
        
        let wholeResult: [String: [String]] = self.inner.keysStore.last ?? ["": []]
        /// 包含key转换处理
        if wholeResult.keys.contains(usedKey) {
            let absorbKeys: [String] = wholeResult[usedKey] ?? []
            for item in absorbKeys {
                if self.json[item] != nil {
                    usedKey = item
                    break
                } else {
                    continue
                }
            }
        } 
        
        guard let object = self.json[usedKey] else {
            if self.json.count == 0 {
                return JSON.null
            } else {
                if self.inner.keysStore.last != nil {
                    for k in self.inner.keysStore.last?[key.stringValue] ?? [] {
                        switch self.json[k] {
                        case .none: continue
                        case .some(let json): return json
                        }
                    }
                    debugPrint("CodingPath: \(self.paths.path), Key: \(key.stringValue) not found, use default value (JSON.null), if you want to custom define key please implement DecodeKeysMappable")
                    return JSON.null
                } else {
                    debugPrint("CodingPath: \(self.paths.path), Key: \(key.stringValue) not found, use default value (JSON.null), if you want to custom define key please implement DecodeKeysMappable")
                    return JSON.null
                }
            }
        }
        return object
    }
}

extension DecodeKeyed {
    var paths: [Path] {
        get { return self.inner.decoder?.paths ?? [] }
        set { self.inner.decoder?.paths = newValue }
    }
}

extension DecodeKeyed {
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unboxNil(json: self.getObject(forKey: key), forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        self.paths.push(value: Path.index(by: key.stringValue), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(forKey: key), forKey: key, type: type)
    }
}

extension DecodeKeyed {
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        let object = try self.getObject(forKey: key)
        return try self.inner.container(keyedBy: type, json: object)
    }

    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let object = try self.getObject(forKey: key)
        return try self.inner.unkeyedContainer(json: object)
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
        return InnerDecoder(json: value, at: self.inner.codingPath, decoder: self.inner.decoder ?? PowerJSONDecoder())
    }
}
