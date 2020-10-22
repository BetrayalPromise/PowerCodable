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

public struct Path {
    let information: String
    let container: Container
    let indexPath: String

    static func index(by: String) -> Path {
        return Path(information: Container.array.rawValue + by, container: .object, indexPath: by)
    }

    static func index(by: Int) -> Path {
        return Path(information: Container.object.rawValue + "\(by)", container: .array, indexPath: "\(by)")
    }
}

public extension Array where Element == Path {
    mutating func push(value: Element, options: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultCase) {
        switch value.container {
        case .array:
            self.append(value)
        case .object:
            var key: String = ""
            switch options {
            case .useDefaultCase:
                key = value.indexPath
            case .useCamelCase(let c):
                key = value.indexPath.toCamelCase(format: c)
            case .useSnakeCase(let c):
                key = value.indexPath.toSnakeCase(format: c)
            case .usePascalCase(let c):
                key = value.indexPath.toPascalCase(format: c)
            case .useUpperCase:
                key = value.indexPath.toUpperCase()
            case .useLowerCase:
                key = value.indexPath.toLowerCase()
            }
            self.append(Path(information: Container.object.rawValue + key, container: Container.object, indexPath: key))
        }
    }

    mutating func pop() {
        if self.count > 0 { self.removeLast() }
    }

    var jsonPath: String {
        return self.reduce("") { (result, item) -> String in
            return result + (item.information)
        }
    }
}

extension Optional {
    var isSome: Bool {
        switch self {
        case .none: return false
        case .some(_): return true
        }
    }

    var isNone: Bool {
        return !self.isSome
    }
}
