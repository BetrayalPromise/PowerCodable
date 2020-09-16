import Foundation

@propertyWrapper
public struct IgnoreNonoptionalCoding<WrappedType: Codable>: Codable {
    public var wrappedValue: WrappedType

    public init(wrappedValue: WrappedType) {
        self.wrappedValue = wrappedValue
        IgnoreCodingStore.nonoptionalValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        guard let value = IgnoreCodingStore.nonoptionalValue as? WrappedType else {
            self.wrappedValue = try WrappedType.init(from: decoder)
            return
        }
        self.wrappedValue = value
    }

    public func encode(to encoder: Encoder) throws {

    }
}

@propertyWrapper
public struct IgnoreOptionalCoding<WrappedType: Codable>: Codable {
    public var wrappedValue: WrappedType?

    public init(wrappedValue: WrappedType?) {
        self.wrappedValue = wrappedValue
        IgnoreCodingStore.optionalValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        guard let value = IgnoreCodingStore.optionalValue as? WrappedType else { return }
        self.wrappedValue = value
    }

    public func encode(to encoder: Encoder) throws {

    }
}

private struct IgnoreCodingStore {
    static var optionalValue: Any?
    static var nonoptionalValue: Any = NSNull()
}




