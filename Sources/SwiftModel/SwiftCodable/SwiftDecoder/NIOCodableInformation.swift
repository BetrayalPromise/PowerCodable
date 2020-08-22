import Foundation

/// 自定义默认值
public struct BoxBaseValue {
    var bool: Bool = false

    var int: Int = 0
    var int8: Int8 = 0
    var int16: Int16 = 0
    var int32: Int32 = 0
    var int64: Int64 = 0

    var uint: UInt = 0
    var uint8: UInt8 = 0
    var uint16: UInt16 = 0
    var uint32: UInt32 = 0
    var uint64: UInt64 = 0

    var float: Float = 0.0
    var double: Double = 0.0

    var string: String = ""
}

extension Bool: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Int: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Int8: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Int16: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Int32: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}


extension Int64: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension UInt: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension UInt8: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension UInt16: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension UInt32: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension UInt64: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Float: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Double: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension String: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

extension Array: Initalizable where Self.Element: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}


extension Dictionary: Initalizable where Self.Key: Initalizable, Self.Value: Initalizable {
    public init(path: AbstractPath, source: Any) {
        self.init()
    }
}

public class AbstractPath: Equatable {
    public static func == (lhs: AbstractPath, rhs: AbstractPath) -> Bool {
        return lhs.codingPath == rhs.codingPath
    }

    private(set) var codingKeys: [CodingKey] = []
    private(set) var codingKey: CodingKey? {
        set {}
        get { return codingKeys.last }
    }
    private(set) var codingPath: String {
        set {}
        get {
            return self.codingKeys.filter { (item) -> Bool in
                if item is NIOCodableKey {
                    return true
                }
                return false
            }.map { (item) -> NIOCodableKey in
                return item as! NIOCodableKey
            }.reduce("") { (result, item) -> String in
                return result + (item.information ?? "")
            }
        }
    }

    init(codingKeys: [CodingKey]) {
        self.codingKeys = codingKeys
    }

    init() {

    }

    @discardableResult
    func array(index: Int) -> AbstractPath {
        self.codingKeys.append(NIOCodableKey(arrayIndex: index))
        return self
    }

    @discardableResult
    func array() -> AbstractPath {
        self.codingKeys.append(NIOCodableKey(string: "[]"))
        return self
    }

    @discardableResult
    func dictionary(index: AnyHashable) -> AbstractPath {
        self.codingKeys.append(NIOCodableKey(dictionaryIndex: index))
        return self
    }

    @discardableResult
    func dictionary() -> AbstractPath {
        self.codingKeys.append(NIOCodableKey(string: "[:]"))
        return self
    }
}
