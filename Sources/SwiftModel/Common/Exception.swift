import Foundation

public struct Coding {
    struct Exception: Swift.Error {
        /// 可能是系统抛出也可能是本工具抛出的错误
        var error: Swift.Error?
        /// 错误码
        let code: StatusCode
    }
    
    public enum StatusCode: Int {
        case invalidJSON = 1 // 无效的JSON
        case invalidTransform = 2 // 无效转化
        case invalidDecode = 3 // 解码错误
        case invalidEncode = 4 // 编码错误
        case invalidUTF8Character = 5 // 无效的UTF8字符
        case invalidUnknow = 6 // 使用了JSON.unknow
        case invalidData = 7 // 无效数据
        case invalidRule = 8 // 数据不唯一(针对正无穷,负无穷,不存在定义标准有重合)
    }
}

extension Coding.Exception {
    /// 无效的JSON
    /// - Returns: 错误
    static func invalidJSON() -> Coding.Exception {
        return Coding.Exception(code: .invalidJSON)
    }

    /// 转化失败
    /// - Returns: 错误
    static func invalidTransform() -> Coding.Exception {
        return Coding.Exception(code: .invalidTransform)
    }

    /// 使用了JSON.unknow
    /// - Returns: 错误
    static func invalidUnknow() -> Coding.Exception {
        return Coding.Exception(code: .invalidUnknow)
    }

    /// 无效的二进制数据
    /// - Returns: 错误
    static func invalidData() -> Coding.Exception {
        return Coding.Exception(code: .invalidData)
    }
    
    
    /// 集合(无穷及不存在)定义冲突,标准不唯一(有相互重叠的部分)
    /// - Parameter sets: 标准集合定义...
    /// - Returns: 错误
    static func invalidRule(sets: Set<String>...) -> Coding.Exception {
        debugPrint("Error: sets(\(sets) can not has intersection")
        return Coding.Exception(code: .invalidRule)
    }

    static func typeMismatch(type: Any.Type, codingPath: [CodingKey] = [], reality: JSON) -> Coding.Exception {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Expected to decode \(type) but found \(reality)) instead.")
        return Coding.Exception(error: DecodingError.typeMismatch(type, context), code: .invalidDecode)
    }

    static func numberMisfit(type: Any.Type, codingPath: [CodingKey] = [] , reality: CustomStringConvertible) -> Coding.Exception {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Parsed JSON number <\(reality)> does not fit in \(type).")
        return Coding.Exception(error: DecodingError.dataCorrupted(context), code: .invalidDecode)
    }

    static func valueNotFound(type: Any.Type, codingPath: [CodingKey] = []) -> Coding.Exception {
        let error = DecodingError.valueNotFound(JSON.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        return Coding.Exception(error: error, code: .invalidDecode)
    }
    
    static func invalidValue(value: Any, codingPath: [CodingKey] = [], reality: JSON) -> Coding.Exception {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Expected to encode \(value) but found \(reality)) instead.")
        return Coding.Exception(error: EncodingError.invalidValue(value, context), code: .invalidEncode)
    }

    static func invalidUTF8Character(value: String) -> Coding.Exception {
        debugPrint(value)
        return Coding.Exception(code: .invalidUTF8Character)
    }
}
