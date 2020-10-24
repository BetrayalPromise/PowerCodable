import Foundation

extension String {
    subscript(i: Int) -> Character {
        if i >= self.count || i < 0 {
            print("Error: out of index \(i)")
            return Character("")
        }
        return self[index(startIndex, offsetBy: i)]
    }

    subscript(range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}

public extension String {
    /// 验证是否为有效的字段名称
    /// - Returns: 验证结果
    func verifyField() -> Bool {
        let regular: String = "^[^0-9].*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return predicate.evaluate(with: self)
    }
}

public enum StringCaseFormat {
    /// 帕斯卡风格
    public enum PascalCase {
        /// Convert from "My Key ID" to "my-key-id"
        case `default`
        /// Convert from "My Key ID" to "my-key-id"
        case lower
        /// Convert from "My Key ID" to "MY-KEY-ID"
        case upper
        /// Convert from "My Key ID" to "My-Key-Id"
        case capitalized
    }

    /// 蛇形风格
    public enum SnakeCase {
        /// Convert from "My Key ID" to "my_key_id"
        case `default`
        /// Convert from "My Key ID" to "my_key_id"
        case lower
        /// Convert from "My Key ID" to "MY_KEY_ID"
        case upper
        /// Convert from "My Key ID" to "My_Key_Id"
        case capitalized
    }

    /// 驼峰风格
    public enum CamelCase {
        /// Convert from "My Key ID" to "myKeyId"
        case `default`
        // Convert from "My Key ID" to "mykeyid"
        case lower
        // Convert from "My Key ID" to "MYKEYID"
        case upper
        /// Convert from "My Key ID" to "MyKeyId"
        case capitalized
    }
}

public extension String {
    func toCamelCase(format: StringCaseFormat.CamelCase = .default) -> String {
        if !self.verifyField() {
            print("Error: invalid field, value = \(self)")
            return ""
        }
        let tokens = tokenize()
        switch format {
        case .default:
            guard let first = tokens.first else {
                return tokens.joined()
            }
            return first.lowercased() + tokens.dropFirst().map { $0.capitalized }.joined()
        case .capitalized:
            return tokens.map { $0.capitalized }.joined()
        case .lower:
            return tokens.map { $0.lowercased() }.joined()
        case .upper:
            return tokens.map { $0.uppercased() }.joined()
        }
    }

    func toSnakeCase(format: StringCaseFormat.SnakeCase = .lower, use separator: String = "_") -> String {
        if !self.verifyField() {
            print("Error: invalid field, value = \(self)")
            return ""
        }
        let tokens = tokenize()
        switch format {
        case .lower, .default:
            return tokens.map { $0.lowercased() }.joined(separator: separator)
        case .upper:
            return tokens.map { $0.uppercased() }.joined(separator: separator)
        case .capitalized:
            return tokens.map { $0.capitalized }.joined(separator: separator)
        }
    }

    func toPascalCase(format: StringCaseFormat.PascalCase = .lower, use separator: String = "-") -> String {
        if !self.verifyField() {
            print("Error: invalid field, value = \(self)")
            return ""
        }
        let tokens = tokenize()
        switch format {
        case .lower, .default:
            return tokens.map { $0.lowercased() }.joined(separator: separator)
        case .upper:
            return tokens.map { $0.uppercased() }.joined(separator: separator)
        case .capitalized:
            return tokens.map { $0.capitalized }.joined(separator: separator)
        }
    }

    func toUpperCase() -> String {
        if !self.verifyField() {
            print("Error: invalid field, value = \(self)")
            return ""
        }
        return self.uppercased()
    }

    func toLowerCase() -> String {
        if !self.verifyField() {
            print("Error: invalid field, value = \(self)")
            return ""
        }
        return self.lowercased()
    }

    private func tokenize() -> [String] {
        var res: [String] = []
        let trim = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let alphanumerics = CharacterSet.alphanumerics
        let uppercaseLetters = CharacterSet.uppercaseLetters
        let lowercaseLetters = CharacterSet.lowercaseLetters
        trim.split(separator: " ").forEach { str in
            var previousCase = 0
            var currentCase = 0
            var caseChange = false
            var scalars = UnicodeScalarView()
            for scalar in str.unicodeScalars {
                if alphanumerics.contains(scalar) {
                    if uppercaseLetters.contains(scalar) {
                        currentCase = 1
                    } else if lowercaseLetters.contains(scalar) {
                        currentCase = 2
                    } else {
                        currentCase = 0
                    }
                    let letterInWord = scalars.count
                    if !caseChange, letterInWord > 0 {
                        if currentCase != previousCase {
                            if previousCase == 1 {
                                if letterInWord > 1 {
                                    caseChange = true
                                }
                            } else {
                                caseChange = true
                            }
                        }
                    }
                    if caseChange {
                        res.append(String(scalars))
                        scalars.removeAll()
                    }
                    scalars.append(scalar)
                    caseChange = false
                    previousCase = currentCase
                } else {
                    caseChange = true
                }
            }
            if !scalars.isEmpty {
                res.append(String(scalars))
            }
        }
        return res
    }
}


extension DateFormatter {
    ///
    static func utc() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        formatter.timeZone = TimeZone.current
        return formatter
    }

    static func iso8601() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone.current
        return formatter
    }
}

extension Date {
    /*
     %a 星期几的简写
     %A 星期几的全称
     %b 月分的简写
     %B 月份的全称
     %c 标准的日期的时间串
     %C 年份的后两位数字
     %d 十进制表示的每月的第几天
     %D 月/天/年
     %e 在两字符域中，十进制表示的每月的第几天
     %F 年-月-日
     %g 年份的后两位数字，使用基于周的年
     %G 年分，使用基于周的年
     %h 简写的月份名
     %H 24小时制的小时
     %I 12小时制的小时
     %j 十进制表示的每年的第几天
     %m 十进制表示的月份
     %M 十时制表示的分钟数
     %n 新行符
     %p 本地的AM或PM的等价显示
     %r 12小时的时间
     %R 显示小时和分钟：hh:mm
     %S 十进制的秒数
     %t 水平制表符
     %T 显示时分秒：hh:mm:ss
     %u 每周的第几天，星期一为第一天 （值从0到6，星期一为0）
     %U 第年的第几周，把星期日做为第一天（值从0到53）
     %V 每年的第几周，使用基于周的年
     %w 十进制表示的星期几（值从0到6，星期天为0）
     %W 每年的第几周，把星期一做为第一天（值从0到53）
     %x 标准的日期串
     %X 标准的时间串
     %y 不带世纪的十进制年份（值从0到99）
     %Y 带世纪部分的十制年份
     %z，%Z 时区名称，如果不能得到时区名称则返回空字符。
     %% 百分号
     */
    func formatted(format: String) -> String? {
        let resultSize = format.count + 200
        var result = [Int8](repeating: 0, count: resultSize)
        var currentTime = time(nil)
        var time = localtime(&currentTime).pointee
        guard strftime(&result, resultSize, format, &time) != 0 else {
            return nil
        }
        return String(cString: result, encoding: .utf8)
    }
}

extension Int {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension Int8 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension Int16 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension Int32 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension Int64 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension UInt {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension UInt8 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension UInt16 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension UInt32 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension UInt64 {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension Float {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}


extension Double {
    func toDate() -> Date {
        let interval: TimeInterval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }
}

extension String {
    func toDate() -> Date {
        guard let interval: TimeInterval = TimeInterval(self) else {
            debugPrint("\(self) cant't transform to TimeInterval, return current date as default")
            return Date()
        }
        return Date(timeIntervalSince1970: interval)
    }
}

