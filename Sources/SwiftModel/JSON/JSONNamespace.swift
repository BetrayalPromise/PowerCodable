import Foundation

public protocol NameSpaceWrappable {
    associatedtype WrapperType
    var json: WrapperType { set get }
    static var json: WrapperType.Type { set get }
}

public extension NameSpaceWrappable {
    var json: NameSpaceWrapper<Self> {
        set {}
        get {
            return NameSpaceWrapper(value: self)
        }
    }

    static var json: NameSpaceWrapper<Self>.Type {
        set {}
        get {
            return NameSpaceWrapper.self
        }
    }
}

public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { set get }
    init(value: WrappedType)
}

public struct NameSpaceWrapper<T>: TypeWrapperProtocol {
    public var wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

extension JSON: NameSpaceWrappable {}

extension TypeWrapperProtocol where WrappedType == JSON {
    public var object: [String: JSON]? {
        guard case .object(let o) = self.wrappedValue else { return nil }
        return o
    }

    public var array: [JSON]? {
        guard case .array(let a) = self.wrappedValue else { return nil }
        return a
    }

    public var string: String? {
        guard case .string(let s) = self.wrappedValue else { return nil }
        return s
    }

    public var integer: Int64? {
        switch self.wrappedValue {
        case .integer(let i): return i
        case .string(let s): return Int64(s)
        default: return nil
        }
    }

    public var bool: Bool? {
        switch self.wrappedValue {
        case .bool(let b): return b
        case .string(let s): return Bool(s)
        default: return nil
        }
    }

    public var double: Double? {
        switch self.wrappedValue {
        case .double(let d): return d
        case .string(let s): return Double(s)
        case .integer(let i): return Double(i)
        default: return nil
        }
    }
    
    public var kind: NodeType {
        switch self.wrappedValue {
        case .unknow: return .null
        case .null: return .null
        case .bool(_): return .bool
        case .integer(_): return .integer
        case .double(_): return .double
        case .string(_): return .string
        case .object(_): return .object
        case .array(_): return .array
        }
    }
}

extension TypeWrapperProtocol where WrappedType == JSON {
    public subscript(index: Int) -> JSON? {
        get {
            guard case .array(let a) = self.wrappedValue, a.indices ~= index else { return nil }
            return a[index]
        }
        set {
            guard case .array(var a) = self.wrappedValue, a.indices ~= index else { return }
            if let newValue = newValue {
                a[index] = newValue
            } else {
                a.remove(at: index)
            }
            self.wrappedValue = .array(a)
        }
    }

    public subscript(key: String) -> JSON? {
        get {
            guard case .object(let object) = self.wrappedValue else { return nil }
            return object[key]
        }
        set {
            guard case .object(var object) = self.wrappedValue else { return }
            object[key] = newValue
            self.wrappedValue = .object(object)
        }
    }
}

extension TypeWrapperProtocol where WrappedType == JSON {
    public var isObject: Bool {
        if case .object(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isArray: Bool {
        if case .array(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isInteger: Bool {
        if case .integer(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isDouble: Bool {
        if case .double(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isBool: Bool {
        if case .bool(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isString: Bool {
        if case .string(_) = self.wrappedValue {
            return true
        } else {
            return false
        }
    }

    public var isNull: Bool {
        if case .null = self.wrappedValue {
            return true
        } else {
            return false
        }
    }
}
