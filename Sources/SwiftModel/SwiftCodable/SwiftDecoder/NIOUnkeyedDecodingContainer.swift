import Foundation

/// 针对数组处理
struct NIOUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    public var isAtEnd: Bool {
        if self.currentIndex == self.count, !self.decoder.codingPath.isEmpty {
            self.decoder.codingPath.removeLast()
        }
        return self.currentIndex >= self.count ?? 0
    }
    
    let decoder: NIODecoder
    var source: [Any]
    var codingPath: [CodingKey] = []
    var currentIndex: Int = 0
    
    public var count: Int? {
        return self.source.count
    }
    var handle: NIOCodableHandle!

    init(decoder: NIODecoder, source: [Any]) {
        self.decoder = decoder
        self.source = source
        self.codingPath = decoder.codingPath
        self.handle = NIOCodableHandle(decoder: decoder)
    }
    
    mutating func decodeNil() throws -> Bool {
        if self.source[self.currentIndex] is NSNull {
            return true
        } else {
            return false
        }
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }

    mutating func decode(_ type: String.Type) throws -> String {
        let value = self.source[self.currentIndex]
        return try self.handle.decode(value: value, type: type, forKey: NIOCodableKey(arrayIndex: self.currentIndex))
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        self.decoder.codingPath.append(NIOCodableKey(arrayIndex: self.currentIndex))
        defer {
            self.currentIndex += 1
            if self.decoder.baseNode == .array && !self.decoder.codingPath.isEmpty {
                self.decoder.codingPath.removeLast()
            }
        }

        if type == Bool.self {
            return try self.decode(Bool.self) as! T
        } else if type == Int.self {
            return try self.decode(Int.self) as! T
        } else if type == Int8.self {
            return try self.decode(Int8.self) as! T
        } else if type == Int16.self {
            return try self.decode(Int16.self) as! T
        } else if type == Int32.self {
            return try self.decode(Int32.self) as! T
        } else if type == Int64.self {
            return try self.decode(Int64.self) as! T
        } else if type == UInt.self {
            return try self.decode(UInt.self) as! T
        } else if type == UInt8.self {
            return try self.decode(UInt8.self) as! T
        } else if type == UInt16.self {
            return try self.decode(UInt16.self) as! T
        } else if type == UInt32.self {
            return try self.decode(UInt32.self) as! T
        } else if type == UInt64.self {
            return try self.decode(UInt64.self) as! T
        } else if type == Float.self {
            return try self.decode(Float.self) as! T
        } else if type == Double.self {
            return try self.decode(Double.self) as! T
        } else if type == String.self {
            return try self.decode(String.self) as! T
        }

        let value: Any = self.source[self.currentIndex]

        guard let model: T = try self.decoder.unbox(value: value, as: type, path: AbstractPath(codingKeys: self.decoder.codingPath)) else {
            if value is [AnyHashable: Any] {
                guard let dictionary: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                    throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "转换失败"))
                }
                if dictionary.isEmpty {
                    switch self.decoder.wrapper?.keyedEmptyValueStrategy {
                    case .useCustom(let delegate):
                        guard let `model`: T = delegate.emptyValue(path: AbstractPath(codingKeys: self.decoder.codingPath), source: self.source[self.currentIndex]) as? T else {
                            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "转换失败"))
                        }
                        return model
                    case .useExecption, .none:
                        throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "转换失败"))
                    }
                }
            }
            return try T.init(from: self.decoder)
        }
        return model
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        defer { self.currentIndex += 1 }
        let value = self.source[self.currentIndex]
        guard let dictionary = value as? [AnyHashable: Any] else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "[:] Execption"))
        }
        return KeyedDecodingContainer(NIOKeyedDecodingContainer<NestedKey>(decoder: self.decoder, source: dictionary))
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return NIOUnkeyedDecodingContainer(decoder: self.decoder, source: self.source)
    }
    
    mutating func superDecoder() throws -> Decoder {
        return self.decoder
    }
}
