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
        return self.uppercased()
    }

    func toLowerCase() -> String {
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
