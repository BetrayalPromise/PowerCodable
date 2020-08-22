import Foundation

/// 针对字典处理
struct NIOKeyedDecodingContainer<K>: KeyedDecodingContainerProtocol where K: CodingKey {
    typealias Key = K
    var codingPath: [CodingKey] = []
    var allKeys: [Key] {
        return self.source.keys.compactMap({ (hash) -> Key? in
            guard let `hash`: String = hash as? String else { return Key(stringValue: "") }
            return Key(stringValue: hash)
        })
    }
    let decoder: NIODecoder
    var source: [AnyHashable: Any] = [:]
    var handle: NIOCodableHandle!
    
    init(decoder: NIODecoder, source: [AnyHashable: Any]) {
        self.decoder = decoder
        self.source = source
        self.codingPath = decoder.codingPath
        self.handle = NIOCodableHandle(decoder: decoder)
    }

    init(decoder: NIODecoder) {
        self.decoder = decoder
    }
    
    func contains(_ key: K) -> Bool {
        return self.allKeys.contains { (item) -> Bool in
            return item.stringValue == key.stringValue ? true : false
        }
    }
    
    func decodeNil(forKey key: K) throws -> Bool {
        if let entry = self.source[key.stringValue] {
            return entry is NSNull
        } else {
            return false
        }
    }
    
    // MARK: Bool
    func decode(_ type: Bool.Type, forKey key: K) throws -> Bool {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Bool.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.bool ?? BoxBaseValue().bool
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Bool.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Bool?
    func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Bool.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.bool ?? BoxBaseValue().bool
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Bool.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int
    func decode(_ type: Int.Type, forKey key: K) throws -> Int {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Int.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int ?? BoxBaseValue().int
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Int.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int?
    func decodeIfPresent(_ type: Int.Type, forKey key: K) throws -> Int? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Int.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int ?? BoxBaseValue().int
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Int.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int8
    func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Int8.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int8 ?? BoxBaseValue().int8
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Int8.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int8?
    func decodeIfPresent(_ type: Int8.Type, forKey key: K) throws -> Int8? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Int8.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int8 ?? BoxBaseValue().int8
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Int8.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int16
    func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Int16.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int16 ?? BoxBaseValue().int16
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Int16.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int16?
    func decodeIfPresent(_ type: Int16.Type, forKey key: K) throws -> Int16? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Int16.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int16 ?? BoxBaseValue().int16
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Int16.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int32
    func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Int32.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int32 ?? BoxBaseValue().int32
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Int32.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int32?
    func decodeIfPresent(_ type: Int32.Type, forKey key: K) throws -> Int32? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Int32.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int32 ?? BoxBaseValue().int32
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Int32.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int64
    func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Int64.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int64 ?? BoxBaseValue().int64
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Int64.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Int64?
    func decodeIfPresent(_ type: Int64.Type, forKey key: K) throws -> Int64? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Int64.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.int64 ?? BoxBaseValue().int64
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Int64.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt
    func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: UInt.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint ?? BoxBaseValue().uint
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: UInt.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt?
    func decodeIfPresent(_ type: UInt.Type, forKey key: K) throws -> UInt? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: UInt.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint ?? BoxBaseValue().uint
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: UInt.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt8
    func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: UInt8.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint8 ?? BoxBaseValue().uint8
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: UInt8.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt8?
    func decodeIfPresent(_ type: UInt8.Type, forKey key: K) throws -> UInt8? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: UInt8.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint8 ?? BoxBaseValue().uint8
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: UInt8.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt16
    func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: UInt16.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint16 ?? BoxBaseValue().uint16
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: UInt16.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt16?
    func decodeIfPresent(_ type: UInt16.Type, forKey key: K) throws -> UInt16? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: UInt16.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint16 ?? BoxBaseValue().uint16
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: UInt16.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt32
    func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: UInt32.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint32 ?? BoxBaseValue().uint32
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: UInt32.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt32?
    func decodeIfPresent(_ type: UInt32.Type, forKey key: K) throws -> UInt32? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: UInt32.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint32 ?? BoxBaseValue().uint32
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: UInt32.self, forKey: replaceKey)
            }
        }
    }

    // MARK: UInt64
    func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: UInt64.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint64 ?? BoxBaseValue().uint64
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: UInt64.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: UInt64?
    func decodeIfPresent(_ type: UInt64.Type, forKey key: K) throws -> UInt64? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: UInt64.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.uint64 ?? BoxBaseValue().uint64
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: UInt64.self, forKey: replaceKey)
            }
        }
    }

    // MARK: Float
    func decode(_ type: Float.Type, forKey key: K) throws -> Float {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Float.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.float ?? BoxBaseValue().float
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Float.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: Float?
    func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Float.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.float ?? BoxBaseValue().float
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Float.self, forKey: replaceKey)
            }
        }
    }

    // MARK: Double
    func decode(_ type: Double.Type, forKey key: K) throws -> Double {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: Double.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.double ?? BoxBaseValue().double
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: Double.self, forKey: replaceKey)
            }
        }
    }

    // MARK: Double?
    func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: Double.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.double ?? BoxBaseValue().double
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: Double.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: String
    func decode(_ type: String.Type, forKey key: K) throws -> String {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decode(value: entry, type: String.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.string ?? BoxBaseValue().string
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decode(value: self.source[replaceKey.stringValue] as Any, type: String.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: String?
    func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String? {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer { self.decoder.codingPath.removeLast() }

        if self.source.keys.contains(key.stringValue) {
            guard let entry: Any = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            return try self.handle.decodeIfPresent(value: entry, type: String.self, forKey: key)
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useDefaultable:
                return self.decoder.wrapper?.boxBaseValue.string ?? BoxBaseValue().string
            case .useNull:
                return nil
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                return try self.handle.decodeIfPresent(value: self.source[replaceKey.stringValue] as Any, type: String.self, forKey: replaceKey)
            }
        }
    }
    
    // MARK: T
    func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer {
            if !self.decoder.codingPath.isEmpty {
                self.decoder.codingPath.removeLast()
            }
        }
        if self.source.keys.contains(key.stringValue) {
            guard let entry = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            self.decoder.storage.push(entry)
            defer { self.decoder.storage.pop() }
            if entry is NSNull {
                switch self.decoder.wrapper?.keyedNullValueStrategy {
                case .useExecption, .none:
                    throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
                case .useCustom(let delegate):
                    let model: Initalizable = delegate.nullValue(path: AbstractPath(codingKeys: self.decoder.codingPath), source: entry)
                    if model is Decodable {
                        return model as! T
                    } else {
                        assert(false, "\(type.self) Must Implementation Protocal Decodable")
                    }
                }
            }
            return try self.decoder.unbox(value: entry, as: type, path: AbstractPath(codingKeys: self.decoder.codingPath)) ?? (type.init(from: self.decoder))
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                self.decoder.storage.push(self.source[replaceKey.stringValue] ?? [:])
                defer { self.decoder.storage.pop() }
                return try self.decoder.unbox(value: self.source[replaceKey.stringValue] ?? "", as: type, path: AbstractPath(codingKeys: self.decoder.codingPath)) ?? type.init(from: self.decoder)
            case .useExecption, .useNull, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useDefaultable:
                return try type.init(from: self.decoder)
            }
        }
    }
    
    // MARK: T?
    func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer {
            if !self.decoder.codingPath.isEmpty {
                self.decoder.codingPath.removeLast()
            }
        }
        if self.source.keys.contains(key.stringValue) {
            guard let entry = self.source[key.stringValue] else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            }
            self.decoder.storage.push(entry)
            defer { self.decoder.storage.pop() }
            if entry is NSNull {
                return nil
            }
            return try self.decoder.unbox(value: entry, as: type, path: AbstractPath(codingKeys: self.decoder.codingPath))
        } else {
            switch self.decoder.wrapper?.keyedKeyNotFoundStrategy {
            case .useCustom(let delegate):
                let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                self.decoder.storage.push(self.source[replaceKey.stringValue] ?? [:])
                defer { self.decoder.storage.pop() }
                return try self.decoder.unbox(value: self.source[replaceKey.stringValue] ?? "", as: type, path: AbstractPath(codingKeys: self.decoder.codingPath)) ?? type.init(from: self.decoder)
            case .useExecption, .none:
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [key], debugDescription: "key: \(key.stringValue) not found"))
            case .useDefaultable:
                return try type.init(from: self.decoder)
            case .useNull:
                return nil
            }
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer {
            self.decoder.codingPath.removeLast()
        }

        guard let dictionary: [AnyHashable: Any] = self.source[key.stringValue] as? [AnyHashable: Any] else {
            return KeyedDecodingContainer(NIOKeyedDecodingContainer<NestedKey>(decoder: self.decoder, source: [:]))
        }
        return KeyedDecodingContainer(NIOKeyedDecodingContainer<NestedKey>(decoder: self.decoder, source: dictionary))
    }
    
    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        self.decoder.codingPath.append(NIOCodableKey(dictionaryIndex: key.stringValue))
        defer {
            self.decoder.codingPath.removeLast()
        }
        guard let array: [Any] = self.source[key.stringValue] as? [Any] else {
            return NIOUnkeyedDecodingContainer(decoder: self.decoder, source: [])
        }
        return NIOUnkeyedDecodingContainer(decoder: self.decoder, source: array)
    }
    
    func superDecoder() throws -> Decoder {
        return self.decoder
    }
    
    func superDecoder(forKey key: K) throws -> Decoder {
        return self.decoder
    }
}
