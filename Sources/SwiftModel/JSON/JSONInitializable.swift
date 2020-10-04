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
