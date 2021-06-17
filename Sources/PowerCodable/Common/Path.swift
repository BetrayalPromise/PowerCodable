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

    let information: String
    let container: Container
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
    mutating func push(value: Element, options: PowerJSONEncoder.KeyFormatEncodingStrategy = .useDefaultKeys) {
        switch value.container {
        case .array: self.append(value)
        case .object:
            var key: String = ""
            switch options {
            case .useDefaultKeys: key = value.indexPath
            case .useCamelKeys(let c): key = value.indexPath.toCamelCase(format: c)
            case .useSnakeKeys(let c): key = value.indexPath.toSnakeCase(format: c)
            case .usePascalKeys(let c): key = value.indexPath.toPascalCase(format: c)
            case .useUpperKeys: key = value.indexPath.toUpperCase()
            case .useLowerKeys: key = value.indexPath.toLowerCase()
            case .useCustom(let closure): key = closure(self).stringValue
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
