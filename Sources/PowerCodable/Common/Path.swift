import Foundation

enum Container: String, CustomStringConvertible {
    case array = "[]"
    case object = "[:]"

    var description: String {
        switch self {
        case .array: return "[]"
        case .object: return "[:]"
        }
    }
}

public struct Path: CodingKey {
    public var stringValue: String {
        return self.indexPath
    }

    public var intValue: Int? {
        return Int(self.indexPath)
    }

    public init?(stringValue: String) {
        self.information = Container.object.rawValue + stringValue
        self.container = .object
        self.indexPath = stringValue
    }

    public init?(intValue: Int) {
        self.information = Container.array.rawValue + "\(intValue)"
        self.container = .array
        self.indexPath = "\(intValue)"
    }

    /// 路径信息
    let information: String
    let container: Container
    /// 索引路径
    let indexPath: String

    static func index(by: String) -> Path {
        return Path(information: Container.object.rawValue + by, container: .object, indexPath: by)
    }

    static func index(by: Int) -> Path {
        return Path(information: Container.array.rawValue + "\(by)", container: .array, indexPath: "\(by)")
    }

    init(information: String, container: Container, indexPath: String) {
        self.information = information
        self.container = container
        self.indexPath = indexPath
    }

    static let `super` = Path(stringValue: "super")!
}

public extension Array where Element == Path {
    mutating func push(value: Element, encoder: PowerJSONEncoder) {
        switch value.container {
        case .array: self.append(value)
        case .object:
            var key: String = value.indexPath
            switch encoder.strategy.key.mapping {
            case .useDefaultKeys: break
            case .useCustomKeys(closue: let closure): key = closure(Path.index(by: value.indexPath), encoder.paths).stringValue
            }
            switch encoder.strategy.key.formatting {
            case .useDefaultKeys: break
            case .useCamelKeys(let c): key = value.indexPath.toCamelCase(format: c)
            case .useSnakeKeys(let c): key = value.indexPath.toSnakeCase(format: c)
            case .usePascalKeys(let c): key = value.indexPath.toPascalCase(format: c)
            case .useUpperKeys: key = value.indexPath.toUpperCase()
            case .useLowerKeys: key = value.indexPath.toLowerCase()
            }
            self.append(Path(information: Container.object.rawValue + key, container: Container.object, indexPath: key))
        }
    }
    
    mutating func push(value: Element, decoder: PowerJSONDecoder) {
        switch value.container {
        case .array: self.append(value)
        case .object:
            var key: String = value.indexPath
            switch decoder.strategy.key.mapping {
            case .useDefaultKeys: break
            case .useCustomKeys(closue: let closure): key = closure(Path.index(by: value.indexPath), decoder.paths).stringValue
            }
            switch decoder.strategy.key.formatting {
            case .useDefaultKeys: break
            case .useCamelKeys(let c): key = value.indexPath.toCamelCase(format: c)
            case .useSnakeKeys(let c): key = value.indexPath.toSnakeCase(format: c)
            case .usePascalKeys(let c): key = value.indexPath.toPascalCase(format: c)
            case .useUpperKeys: key = value.indexPath.toUpperCase()
            case .useLowerKeys: key = value.indexPath.toLowerCase()
            }
            self.append(Path(information: Container.object.rawValue + key, container: Container.object, indexPath: key))
        }
    }

    mutating func pop() {
        if self.count > 0 { self.removeLast() }
    }

    /// 当前使用的编码路径
    var path: String {
        return self.reduce("") { (result, item) -> String in
            return result + (item.information)
        }
    }
}

extension String {
    var path: Path { return Path.index(by: self) }
}

extension Int {
    var path: Path { return Path.index(by: self) }
}
