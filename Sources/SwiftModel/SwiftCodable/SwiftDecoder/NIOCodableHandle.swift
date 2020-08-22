import Foundation

struct NIOCodableHandle {
    var convertTypeStrategy: NIOJSONDecoder.ConvertTypeStrategy = .useDefaultable
    var decoder: NIODecoder

    init(decoder: NIODecoder) {
        self.decoder = decoder
        self.convertTypeStrategy = decoder.wrapper?.convertTypeStrategy ?? .useDefaultable
    }
}

extension NIOCodableHandle: TypeConvertible {

}

// MARK: - 处理Bool和Bool?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Bool.Type, forKey key: K) throws -> Bool where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber can't convert to Bool"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Bool type unsupport :\(value), set default false")
                    return false
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Bool type unsupport :\(value), set default false")
            return false
        }
    }

    func decodeIfPresent<K>(value: Any, type: Bool.Type, forKey key: K) throws -> Bool? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber can't convert to Bool"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Bool type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBoolIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Bool.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toBool(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Bool type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Int和Int?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Int.Type, forKey key: K) throws -> Int where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber can't convert to Bool"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else  {
                    print("Int type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if  value is String {
            guard let value: String = value as? String else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Dictionary can't convert to Int"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Int type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Int.Type, forKey key: K) throws -> Int? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber can't convert to Bool"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else  {
                    print("Int type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if  value is String {
            guard let value: String = value as? String else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Dictionary can't convert to Int"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Int type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Int8和Int8?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Int8.Type, forKey key: K) throws -> Int8 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int8"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("Int8 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if value is String {
            guard let `value`: String = value as? String else {
                throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "无法转化为String"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int8 type unsupport :\(value), set default nil")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Int8.Type, forKey key: K) throws -> Int8? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int8"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("Int8 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if value is String {
            guard let value: String = value as? String else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "无法转化为String"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int8 type unsupport :\(value), set default nil")
            return nil
        }
    }

}

// MARK: - 处理Int16和Int16?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Int16.Type, forKey key: K) throws -> Int16 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int8"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Int16 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int16 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Int16.Type, forKey key: K) throws -> Int16? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int8"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Int16 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        }  else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int16 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Int32和Int32?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Int32.Type, forKey key: K) throws -> Int32 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("Int32 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if value is String {
            guard let `value`: String = value as? String else {
                throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "无法转化为String"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int32 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Int32.Type, forKey key: K) throws -> Int32? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("Int32 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if value is String {
            guard let `value`: String = value as? String else {
                throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "无法转化为String"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int32 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Int64和Int64?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Int64.Type, forKey key: K) throws -> Int64 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Int64 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int64 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Int64.Type, forKey key: K) throws -> Int64? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Int64 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Int64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Int64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        }  else {
            print("Int64 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理UInt和UInt?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: UInt.Type, forKey key: K) throws -> UInt where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: UInt.Type, forKey key: K) throws -> UInt? where K: CodingKey  {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUIntIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理UInt8和UInt8?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: UInt8.Type, forKey key: K) throws -> UInt8 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt8 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt8 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: UInt8.Type, forKey key: K) throws -> UInt8? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt8 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt8IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt8 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理UInt16和UInt16?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: UInt16.Type, forKey key: K) throws -> UInt16 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt16 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt16 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: UInt16.Type, forKey key: K) throws -> UInt16? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt16 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt16IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt16 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理UInt32和UInt32?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: UInt32.Type, forKey key: K) throws -> UInt32 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("UInt32 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt32 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: UInt32.Type, forKey key: K) throws -> UInt32? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                }  else {
                    print("UInt32 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt32IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt32 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理UInt64和UInt64?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: UInt64.Type, forKey key: K) throws -> UInt64 where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt64 type unsupport :\(value), set default 0")
                    return 0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt64 type unsupport :\(value), set default 0")
            return 0
        }
    }

    func decodeIfPresent<K>(value: Any, type: UInt64.Type, forKey key: K) throws -> UInt64? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return try self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return try delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("UInt64 type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toUInt64IfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("UInt64 type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Float和Float?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Float.Type, forKey key: K) throws -> Float where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                        case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                        case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Float type unsupport :\(value), set default 0.0")
                    return 0.0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Float.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Float.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloat(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Float type unsupport :\(value), set default 0.0")
            return 0.0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Float.Type, forKey key: K) throws -> Float? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Float type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Float.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Float.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toFloatIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Float type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理Double和Double?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: Double.Type, forKey key: K) throws -> Double where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Double type unsupport :\(value), set default 0.0")
                    return 0.0
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDouble(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Double type unsupport :\(value), set default 0.0")
            return 0.0
        }
    }

    func decodeIfPresent<K>(value: Any, type: Double.Type, forKey key: K) throws -> Double? where K: CodingKey  {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Double type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toDoubleIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Double type unsupport :\(value), set default nil")
            return nil
        }
    }
}

// MARK: - 处理String和String?类型
extension NIOCodableHandle {
    func decode<K>(value: Any, type: String.Type, forKey key: K) throws -> String where K: CodingKey {
        if value is NSNull {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: NSNull())
            }
        } else if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Double type unsupport :\(value), set default \"\"")
                    return ""
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toString(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Double type unsupport :\(value), set default \"\"")
            return ""
        }
    }

    func decodeIfPresent<K>(value: Any, type: String.Type, forKey key: K) throws -> String? where K: CodingKey {
        if value is NSNumber {
            guard let value: NSNumber = value as? NSNumber else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "can't convert to NSNumber"))
            }
            if value === kCFBooleanTrue || value === kCFBooleanFalse {
                guard let value: Bool = value as? Bool else {
                    throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "NSNumber cant't convert to Int32"))
                }
                switch self.convertTypeStrategy {
                case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                }
            } else {
                if let `value`: Int = value as? Int {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int8 = value as? Int8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int16 = value as? Int16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int32 = value as? Int32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Int64 = value as? Int64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt = value as? UInt {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt8 = value as? UInt8 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt16 = value as? UInt16 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt32 = value as? UInt32 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: UInt64 = value as? UInt64 {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Double = value as? Double {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else if let `value`: Float = value as? Float {
                    switch self.convertTypeStrategy {
                    case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
                    }
                } else {
                    print("Double type unsupport :\(value), set default nil")
                    return nil
                }
            }
        } else if let `value`: String = value as? String {
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [AnyHashable: Any] {
            guard let value: [AnyHashable: Any] = value as? [AnyHashable: Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else if value is [Any] {
            guard let value: [Any] = value as? [Any] else {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key: \(key.stringValue) not found"))
            }
            switch self.convertTypeStrategy {
            case .useDefaultable: return self.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            case .useCustom(let delegate): return delegate.toStringIfPresent(path: AbstractPath(codingKeys: self.decoder.codingPath), value: value)
            }
        } else {
            print("Double type unsupport :\(value), set default nil")
            return nil
        }
    }
}

