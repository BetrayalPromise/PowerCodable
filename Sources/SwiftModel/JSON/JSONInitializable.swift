import Foundation

public protocol JSONInitializable {
    init(json: JSON) throws
}

extension JSONInitializable {
    public static func decode(_ json: JSON) throws -> Self {
        return try Self(json: json)
    }
}

extension Bool: JSONInitializable {
    public init(json: JSON) throws {
        guard let b = json.bool else { throw JSON.Error.badValue(json) }
        self = b
    }
}

extension String: JSONInitializable {
    public init(json: JSON) throws {
        guard let s = json.string else { throw JSON.Error.badValue(json) }
        self = s
    }
}

extension Double: JSONInitializable {
    public init(json: JSON) throws {
        guard let d = json.double else { throw JSON.Error.badValue(json) }
        self = d
    }
}

extension Float: JSONInitializable {
    public init(json: JSON) throws {
        guard let f = json.float else { throw JSON.Error.badValue(json) }
        self = f
    }
}

extension Int: JSONInitializable {
    public init(json: JSON) throws {
        guard let i = json.int else { throw JSON.Error.badValue(json) }
        self = i
    }
}

extension Int64: JSONInitializable {
    public init(json: JSON) throws {
        guard let i = json.int64 else { throw JSON.Error.badValue(json) }
        self = i
    }
}

extension Optional where Wrapped: JSONInitializable {
    public init(json: JSON) throws {
        self = try Wrapped(json: json)
    }

    public static func decode(json: JSON) throws -> Optional<Wrapped> {
        return try Optional<Wrapped>(json: json)
    }
}

extension RawRepresentable where RawValue: JSONInitializable {
    public init(json: JSON) throws {
        guard let value = try Self(rawValue: RawValue(json: json)) else { throw JSON.Error.badValue(json) }
        self = value
    }

    public static func decode(json: JSON) throws -> Self {
        return try Self(json: json)
    }
}

extension Array where Element: JSONInitializable {
    public init(json: JSON) throws {
        guard let array = json.array else { throw JSON.Error.badValue(json) }
        self = try array.map(Element.init(json:))
    }

    public static func decode(json: JSON) throws -> [Element] {
        return try Array<Element>(json: json)
    }
}

public protocol JSONConvertible: JSONInitializable, JSONRepresentable {}

extension JSON: JSONConvertible {
    public init(json: JSON) throws {
        self = json
    }

    public func encoded() -> JSON {
        return self
    }
}

extension JSON {
    init(array: [JSON]) {
        self = .array(array)
    }

    init(object: [String: JSON]) {
        self = .object(object)
    }

    static func emptyArray() -> JSON {
        return JSON(array: [])
    }

    static func emptyObject() -> JSON {
        return JSON(object: [:])
    }
}

// MARK: - ExpressibleBy
extension JSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSONRepresentable...) {
        let array = elements.map({ $0.encoded() })
        self = .array(array)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSONRepresentable)...) {
        var dict: [String: JSON] = [:]
        for (key, value) in elements {
            dict[key] = value.encoded()
        }
        self = .object(dict)
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        let val = Int64(value)
        self = .integer(val)
    }
}

extension JSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        let val = Double(value)
        self = .double(val)
    }
}

extension JSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self = .string(value)
    }
}

extension JSON: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .null
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}
