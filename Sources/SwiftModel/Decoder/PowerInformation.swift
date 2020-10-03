import Foundation

public struct Path {
    var information: String = ""

    static func index(by: String) -> Path {
        return Path(information: "[:]" + by)
    }

    static func index(by: Int) -> Path {
        return Path(information: "[]\(by)")
    }
}

public extension Array where Element == Path {
    mutating func push(value: Element) {
        self.append(value)
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
