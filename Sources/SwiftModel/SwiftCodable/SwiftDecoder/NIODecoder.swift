import Foundation

/// 实际使用的解码器
class NIODecoder: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]
    var source: Any
    var storage: OperationData = OperationData()
    weak var wrapper: NIOJSONDecoder?

    var baseNode: BaseNode = .none

    init(wrapper: NIOJSONDecoder, source: Any, codingPath: [CodingKey] = [], userInfo: [CodingUserInfoKey : Any] = [:]) {
        self.wrapper = wrapper
        self.source = source
        self.codingPath = codingPath
        self.userInfo = userInfo
        if source is [Any] {
            self.baseNode = .array
        } else if source is [AnyHashable: Any] {
            self.baseNode = .dictionary
        } else {
            self.baseNode = .none
        }
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        guard let dictionary: [AnyHashable: Any] = self.storage.currentValue as? [AnyHashable: Any] else {
            return KeyedDecodingContainer<Key>(NIOKeyedDecodingContainer(decoder: self, source: [:]))
        }
        return KeyedDecodingContainer<Key>(NIOKeyedDecodingContainer(decoder: self, source: dictionary))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let array: [Any] = self.storage.currentValue as? [Any] else {
            return NIOUnkeyedDecodingContainer(decoder: self, source: [])
        }
        return NIOUnkeyedDecodingContainer(decoder: self, source: array)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return NIOSingleValueDecodingContainer(decoder: self)
    }
}

extension NIODecoder {
    func cleanup() {
        self.codingPath.removeAll()
        self.storage.container.removeAll()
        self.source = Empty()
    }
}

extension NIODecoder {
    func unbox<T>(value: Any, as type: T.Type, path: AbstractPath) throws -> T? where T: Decodable {
        self.storage.push(value)
        defer { self.storage.pop() }
        if value is [AnyHashable: Any] {
            guard let `value`: [AnyHashable: Any] = value as? [AnyHashable : Any]  else { throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: self.codingPath, debugDescription: "[] conversion Execption")) }
            if value.isEmpty {
                switch self.wrapper?.keyedEmptyValueStrategy {
                case .useCustom(let delegate):
                    let model: Initalizable = delegate.emptyValue(path: AbstractPath(codingKeys: self.codingPath), source: source)
                    if model is Decodable {
                        return model as? T
                    } else {
                        assert(false, "\(type.self) Must Implementation Protocal Decodable")
                    }
                case .useExecption, .none:
                    throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: self.codingPath, debugDescription: "[] conversion Execption"))
                }
            }
        }

        do {
            return try type.init(from: self)
        } catch  {
            throw error
        }
    }
}

struct OperationData {
    var container: [Any] = []
    var count: Int { return self.container.count }
    var currentValue: Any? { return self.container.last }
    mutating func push(_ value: Any) { self.container.append(value) }
    mutating func pop() { if self.container.count > 0 { self.container.removeLast() } }
}

enum BaseNode {
    case none
    case array
    case dictionary
}

private struct Empty {

}
