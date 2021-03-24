import Foundation

@available(swift 5.1)
public struct Decoding: Codable {
    private static var optionalValue: Any? = nil
    private static var nonoptionalValue: Any = Null()

    /// 不使用JSON数据的值, 而使用自定义实体的默认初始化值
    @propertyWrapper
    public struct IgnoreOptional<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType?

        public init(wrappedValue: WrappedType?) {
            self.wrappedValue = wrappedValue
            Decoding.optionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = Decoding.optionalValue as? WrappedType else { return }
            self.wrappedValue = value
        }

        public func encode(to encoder: Encoder) throws {
            try self.wrappedValue.encode(to: encoder)
        }
    }

    /// 不使用JSON数据的值, 而使用自定义实体的默认初始化值
    @propertyWrapper
    public struct IgnoreNonoptional<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType

        public init(wrappedValue: WrappedType) {
            self.wrappedValue = wrappedValue
            Decoding.nonoptionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = Decoding.nonoptionalValue as? WrappedType else {
                self.wrappedValue = try WrappedType.init(from: decoder)
                return
            }
            self.wrappedValue = value
        }

        public func encode(to encoder: Encoder) throws {
            try self.wrappedValue.encode(to: encoder)
        }
    }
}

//extension KeyedDecodingContainer {
//    public func decode<T>(_ type: IgnoreDecoding.OptionalCoding<T>.Type, forKey key: Key) throws -> IgnoreDecoding.OptionalCoding<T> where T: DefaultValue {
//        try decodeIfPresent(type, forKey: key) ?? IgnoreDecoding.OptionalCoding<T>(wrappedValue: T())
//    }
//
//    public func decode<T>(_ type: IgnoreDecoding.OptionalCoding<T?>.Type, forKey key: Key) throws -> IgnoreDecoding.OptionalCoding<T?> where T: DefaultValue {
//        try decodeIfPresent(type, forKey: key) ?? IgnoreDecoding.OptionalCoding<T?>(wrappedValue: T())
//    }
//
//    public func decode<T>(_ type: IgnoreDecoding.Value<T>.Type, forKey key: Key) throws -> IgnoreDecoding.Value<T> where T: DefaultValue {
//        try decodeIfPresent(type, forKey: key) ?? IgnoreDecoding.Value<T>(wrappedValue: T())
//    }
//
//    public func decode<T>(_ type: IgnoreDecoding.Value<T?>.Type, forKey key: Key) throws -> IgnoreDecoding.Value<T?> where T: DefaultValue {
//        try decodeIfPresent(type, forKey: key) ?? IgnoreDecoding.Value<T?>(wrappedValue: T())
//    }
//}

//public protocol DefaultValue {
//    associatedtype Value: Decodable
//    static var `default`: Value { get }
//}
//
//@available(swift 5.1)
//@propertyWrapper
//public struct Default<T: DefaultValue> {
//    public var wrappedValue: T.Value
//
//    public init(value: T.Value) {
//        self.wrappedValue = value
//    }
//}
//
//extension Default: Decodable {
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        self.wrappedValue = (try? container.decode(T.Value.self)) ?? T.default
//    }
//}
//
//extension KeyedDecodingContainer {
//    public func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
//        try decodeIfPresent(type, forKey: key) ?? Default(value: T.default)
//    }
//}

@propertyWrapper
struct Default<T: Decodable & DefaultValue>: Decodable {
    var value: T = T.init()
    var wrappedValue: T {
        set {
            self.value = newValue
        }
        get {
            return value
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let v = (try? container.decode(T.self)) ?? self.value
        self.wrappedValue = v
    }
}

protocol DefaultValue {
    init()
}

extension Bool: DefaultValue {
    init() {
        self = false
    }
}

extension Int: DefaultValue {
    init() {
        self = 0
    }
}

extension Int8: DefaultValue {
    init() {
        self = 0
    }
}

extension Int16: DefaultValue {
    init() {
        self = 0
    }
}

extension Int32: DefaultValue {
    init() {
        self = 0
    }
}

extension Int64: DefaultValue {
    init() {
        self = 0
    }
}

extension UInt: DefaultValue {
    init() {
        self = 0
    }
}

extension UInt8: DefaultValue {
    init() {
        self = 0
    }
}

extension UInt16: DefaultValue {
    init() {
        self = 0
    }
}

extension UInt32: DefaultValue {
    init() {
        self = 0
    }
}

extension UInt64: DefaultValue {
    init() {
        self = 0
    }
}

extension Float: DefaultValue {
    init() {
        self = 0.0
    }
}

extension Double: DefaultValue {
    init() {
        self = 0.0
    }
}

extension String: DefaultValue {
    init() {
        self = ""
    }
}


extension Optional: DefaultValue where Wrapped: Decodable {
    init() {
        self = nil
    }
}

