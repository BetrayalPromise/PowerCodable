import Foundation

/// MARK: JSON抽象 由于Swift中的JSON解析器给出的是Any类型 无法明确需要强转后再处理, 本工具使用JSON结构体明确可以看出JSON结构
@dynamicMemberLookup
public enum JSON: JSONCodingSupport {
    case unknow // 给定一个unknow的初始值区别与null, 任何使用unknow的处理都会抛出异常
    case null
    case bool(Bool)
    case integer(Int64)
    case double(Double)
    case string(String)
    indirect case object([String: JSON])
    indirect case array([JSON])

    /// @dynamicMemberLookup
    subscript(dynamicMember member: String) -> JSON {
        return (try? self.get(member)) ?? .null
    }

    typealias Wrapper = JSON

    var dataWrapper: Data? {
        do {
            let string: String = try JSON.Serializer.serialize(self)
            return string.data(using: String.Encoding.utf8)
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension JSON {
    func path() -> (String, Error?) {
        do {
            return (try JSON.Serializer.serialize(self), nil)
        } catch {
            return ("", Error.badValue(self))
        }
    }
}

// MARK: - JSON Equatable协议
extension JSON: Equatable {
    static public func ==(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.object(let l), .object(let r)): return l == r
        case (.array(let l), .array(let r)): return l == r
        case (.null, .null): return true
        case (.bool(let l), .bool(let r)): return l == r
        case (.string(let l), .string(let r)): return l == r
        case (.double(let l), .double(let r)): return l == r
        case (.integer(let l), .integer(let r)): return l == r
        case (.unknow, .unknow): return true
        case (.unknow, .object(_)): return false
        case (.unknow, .array(_)): return false
        case (.unknow, .null): return false
        case (.unknow, .bool(_)): return false
        case (.unknow, .string(_)): return false
        case (.unknow, .integer(_)): return false
        case (.unknow, .double(_)): return false
        case (.integer(_), .object(_)): return false
        case (.integer(_), .array(_)): return false
        case (.integer(_), .null): return false
        case (.integer(_), .bool(_)): return false
        case (.integer(_), .string(_)): return false
        case (.integer(_), .double(_)): return false
        case (.integer(_), .unknow): return false
        case (.double(_), .object(_)): return false
        case (.double(_), .array(_)): return false
        case (.double(_), .null): return false
        case (.double(_), .bool(_)): return false
        case (.double(_), .string(_)): return false
        case (.double(_), .integer(_)): return false
        case (.double(_), .unknow): return false
        case (.string(_), .object(_)): return false
        case (.string(_), .array(_)): return false
        case (.string(_), .null): return false
        case (.string(_), .bool(_)): return false
        case (.string(_), .integer(_)): return false
        case (.string(_), .double(_)): return false
        case (.string(_), .unknow): return false
        case (.bool(_), .object(_)): return false
        case (.bool(_), .array(_)): return false
        case (.bool(_), .null): return false
        case (.bool(_), .string(_)): return false
        case (.bool(_), .integer(_)): return false
        case (.bool(_), .double(_)): return false
        case (.bool(_), .unknow): return false
        case (.null, .object(_)): return false
        case (.null, .array(_)): return false
        case (.null, .bool(_)): return false
        case (.null, .string(_)): return false
        case (.null, .integer(_)): return false
        case (.null, .double(_)): return false
        case (.null, .unknow): return false
        case (.array(_), .object(_)): return false
        case (.array(_), .null): return false
        case (.array(_), .bool(_)): return false
        case (.array(_), .string(_)): return false
        case (.array(_), .integer(_)): return false
        case (.array(_), .double(_)): return false
        case (.array(_), .unknow): return false
        case (.object(_), .array(_)): return false
        case (.object(_), .null): return false
        case (.object(_), .bool(_)): return false
        case (.object(_), .string(_)): return false
        case (.object(_), .integer(_)): return false
        case (.object(_), .double(_)): return false
        case (.object(_), .unknow): return false
        }
    }
}

// MARK: - JSON: CustomStringConvertible
extension JSON {
    /**
     Turns a nested graph of `JSON`s into a Swift `String`. This produces JSON data that
     strictly conforms to [RFT7159](https://tools.ietf.org/html/rfc7159).
     It can optionally pretty-print the output for debugging, but this comes with a non-negligible performance cost.
     */
    public func serialized(options: JSON.Serializer.Option = []) throws -> String {
        return try JSON.Serializer.serialize(self, options: options)
    }
}

extension JSON: CustomStringConvertible {
    public var description: String {
        do {
            return try self.serialized()
        } catch {
            return String(describing: error)
        }
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        do {
            return try self.serialized(options: .prettyPrint)
        } catch {
            return String(describing: error)
        }
    }
}

extension JSON: Sequence {
    public func makeIterator() -> AnyIterator<JSON> {
        switch self {
        case .array(let array):
            var iterator = array.makeIterator()
            return AnyIterator {
                return iterator.next()
            }
        case .object(let object):
            var iterator = object.makeIterator()
            return AnyIterator {
                guard let (key, value) = iterator.next() else { return nil }
                return .object([key: value])
            }
        default:
            var value: JSON? = self
            return AnyIterator {
                defer { value = nil }
                if case .null? = value { return nil }
                return value
            }
        }
    }
}

// MARK: - JSON error
extension JSON {
    /// Represent an error resulting during mapping either, to or from an instance type.
    public enum Error: Swift.Error {
        // BadField indicates an error where a field was missing or was of the wrong type. The associated value represents the name of the field.
        case badField(String)
        /// When thrown during initialization it indicates a value in the JSON could not be converted to RFC
        case badValue(JSON)
        /// A number was not valid per the JSON spec. (handled in Parser?)
        case invalidNumber
    }
}
