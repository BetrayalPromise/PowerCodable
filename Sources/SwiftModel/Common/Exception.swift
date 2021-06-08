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
        case invalidTypeTransform = 2 // 无效转化
        case unsupportType = 3 // 不支持的类型
        case decodingError = 4 // 解码错误
        case encodingError = 5 // 编码错误
        case invalidUTF8String = 6 // 无效的UTF8字符
        case jsonUnknow = 7 // 使用了JSON.unknow
        case notFoundData = 8 // 无数据
        case nonUniqueness = 9 // 数据不唯一
    }
}

extension Coding.Exception {
    /// 类型不支持
    static func unsupportType() -> Coding.Exception {
        return Coding.Exception(code: .unsupportType)
    }

    /// 无效的json
    static func invalidJSON() -> Coding.Exception {
        return Coding.Exception(code: .invalidJSON)
    }

    /// 转化失败
    static func invalidTypeTransform() -> Coding.Exception {
        return Coding.Exception(code: .invalidTypeTransform)
    }

    /// 无效的json
    static func unknowJSON() -> Coding.Exception {
        return Coding.Exception(code: .jsonUnknow)
    }

    static func notFoundData() -> Coding.Exception {
        return Coding.Exception(code: .notFoundData)
    }
    
    static func nonUniqueness(sets: Set<String>...) -> Coding.Exception {
        debugPrint("Error: sets(\(sets) can not has intersection")
        return Coding.Exception(code: .nonUniqueness)
    }

    static func typeMismatch(type: Any.Type, codingPath: [CodingKey] = [], reality: JSON) -> Coding.Exception {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Expected to decode \(type) but found \(reality)) instead.")
        return Coding.Exception(error: DecodingError.typeMismatch(type, context), code: .decodingError)
    }

    static func numberMisfit(type: Any.Type, codingPath: [CodingKey] = [] , reality: CustomStringConvertible) -> Coding.Exception {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Parsed JSON number <\(reality)> does not fit in \(type).")
        return Coding.Exception(error: DecodingError.dataCorrupted(context), code: .decodingError)
    }

    static func valueNotFound(type: Any.Type, codingPath: [CodingKey] = []) -> Coding.Exception {
        let error = DecodingError.valueNotFound(JSON.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        return Coding.Exception(error: error, code: .decodingError)
    }
    
    static func invalidValue(value: Any, codingPath: [CodingKey] = [], reality: JSON) -> Coding.Exception {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Expected to encode \(value) but found \(reality)) instead.")
        return Coding.Exception(error: EncodingError.invalidValue(value, context), code: .encodingError)
    }

    static func invalidUTF8String(value: String) -> Coding.Exception {
        debugPrint(value)
        return Coding.Exception(code: .invalidUTF8String)
    }
}
