import Foundation

@available(swift 5.1)
public struct IgnoreDecoding: Codable {
    private static var optionalValue: Any? = nil
    private static var nonoptionalValue: Any = Null()

    /// 不使用JSON数据的值, 而使用自定义实体的默认初始化值
    @propertyWrapper
    public struct OptionalCoding<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType?

        public init(wrappedValue: WrappedType?) {
            self.wrappedValue = wrappedValue
            IgnoreDecoding.optionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = IgnoreDecoding.optionalValue as? WrappedType else { return }
            self.wrappedValue = value
        }

        public func encode(to encoder: Encoder) throws {
            try self.wrappedValue.encode(to: encoder)
        }
    }

    /// 不使用JSON数据的值, 而使用自定义实体的默认初始化值
    @propertyWrapper
    public struct NonoptionalCoding<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType

        public init(wrappedValue: WrappedType) {
            self.wrappedValue = wrappedValue
            IgnoreDecoding.nonoptionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = IgnoreDecoding.nonoptionalValue as? WrappedType else {
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

//private var wrapper: Any?  = nil
//@available(swift 5.1)
//@propertyWrapper
//public struct Decoding<Wrapped: Codable & DefaultValue>: Codable {
//    var keys: [String] = []
//    var value: Wrapped = Wrapped()
//
//    public var wrappedValue: Wrapped {
//        return self.value
//    }
//
//    public init(keys: [String], `else`: Wrapped) {
//        self.keys = keys
//        self.value = `else`
//        wrapper = self
//    }
//
//    public init(from decoder: Decoder) throws {
//        guard let decoder = decoder as? PowerInnerJSONDecoder else {
//            return
//        }
//        guard let value = wrapper as? Decoding<Wrapped> else {
//            debugPrint("转化失败")
//            return
//        }
//        print(decoder.json)
//        self = value
//        for item in value.keys {
//            print(item)
//        }
//        wrapper = nil
//    }
//}

public protocol DefaultValue {
    init()
}
extension Bool: DefaultValue {}
extension Int: DefaultValue {}
extension Int8: DefaultValue {}
extension Int16: DefaultValue {}
extension Int32: DefaultValue {}
extension Int64: DefaultValue {}
extension UInt: DefaultValue {}
extension UInt8: DefaultValue {}
extension UInt16: DefaultValue {}
extension UInt32: DefaultValue {}
extension UInt64: DefaultValue {}
extension Float: DefaultValue {}
extension Double: DefaultValue {}
extension String: DefaultValue {}


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
//
//extension String: DefaultValue {
//    public static var `default`: String {
//        return ""
//    }
//
//    public typealias Value = Self
//}
