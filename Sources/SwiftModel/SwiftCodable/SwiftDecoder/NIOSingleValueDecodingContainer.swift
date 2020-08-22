import Foundation

/// 针对自定义处理
struct NIOSingleValueDecodingContainer: SingleValueDecodingContainer {
    var codingPath: [CodingKey] = []
    
    let decoder: NIODecoder
    var handle: NIOCodableHandle!
    
    init(decoder: NIODecoder) {
        self.decoder = decoder
        self.handle = NIOCodableHandle(decoder: decoder)
        self.codingPath = decoder.codingPath
    }
    
    func decodeNil() -> Bool {
        if self.decoder.wrapper?.convertNullStrategy == true {
            return false
        }
        return self.decoder.storage.currentValue is NSNull ? true : false
    }
    // MARK: - Bool
    func decode(_ type: Bool.Type) throws -> Bool {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }
        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Bool.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Bool.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Bool.self, forKey: key)
    }

    // MARK: - Int
    func decode(_ type: Int.Type) throws -> Int {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Int.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Int.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Int.self, forKey: key)
    }

    // MARK: - Int8
    func decode(_ type: Int8.Type) throws -> Int8 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Int8.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Int8.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Int8.self, forKey: key)
    }

    // MARK: - Int16
    func decode(_ type: Int16.Type) throws -> Int16 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Int16.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Int16.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Int16.self, forKey: key)
    }

    // MARK: - Int32
    func decode(_ type: Int32.Type) throws -> Int32 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Int32.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Int32.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Int32.self, forKey: key)
    }

    // MARK: - Int64
    func decode(_ type: Int64.Type) throws -> Int64 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Int64.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Int64.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Int64.self, forKey: key)
    }
    // MARK: - UInt
    func decode(_ type: UInt.Type) throws -> UInt {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: UInt.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: UInt.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: UInt.self, forKey: key)
    }

    // MARK: - UInt8
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: UInt8.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: UInt8.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: UInt8.self, forKey: key)
    }

    // MARK: - UInt16
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: UInt16.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: UInt16.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: UInt16.self, forKey: key)
    }

    // MARK: - UInt32
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: UInt32.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: UInt32.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: UInt32.self, forKey: key)
    }

    // MARK: - UInt64
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: UInt64.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: UInt64.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: UInt64.self, forKey: key)
    }

    // MARK: - Float
    func decode(_ type: Float.Type) throws -> Float {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Float.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Float.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Float.self, forKey: key)
    }

    // MARK: - Double
    func decode(_ type: Double.Type) throws -> Double {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: Double.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: Double.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: Double.self, forKey: key)
    }

    // MARK: - String
    func decode(_ type: String.Type) throws -> String {
        guard let value = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法解析\(type)", underlyingError: nil))
        }
        guard let key = NIOCodableKey(stringValue: self.decoder.codingPath.last?.stringValue ?? "") else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法找到Key", underlyingError: nil))
        }

        if value is [AnyHashable: Any] {
            guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "转化失败", underlyingError: nil))
            }
            if dictionary.keys.contains(key.stringValue) {
                return try self.handle.decode(value: value, type: String.self, forKey: key)
            } else {
                switch self.decoder.wrapper?.decodingSingleKeyNotFoundStrategy {
                case .useCustom(let delegate):
                    let replaceKey = NIOCodableKey(string: delegate.key(sourcePath: AbstractPath(codingKeys: self.decoder.codingPath)).codingPath)
                    return try self.handle.decode(value: dictionary[replaceKey.stringValue] as Any, type: String.self, forKey: replaceKey)
                case .useExecption, .none:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Key Mismatching", underlyingError: nil))
                }
            }
        }
        return try self.handle.decode(value: value, type: String.self, forKey: key)
    }

    // MARK: - T
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        guard let value: Any = self.decoder.storage.currentValue else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "无法取值\(type)", underlyingError: nil))
        }
        return try self.decoder.unbox(value: value, as: type, path: AbstractPath(codingKeys: self.decoder.codingPath)) ?? (try type.init(from: self.decoder))
    }
}

