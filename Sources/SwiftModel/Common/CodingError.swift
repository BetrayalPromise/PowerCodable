import Foundation

public struct CodingError: Swift.Error {
    public enum ErrorCode: Int {
        case invalidJSON = 0 // 无效的JSON
        case invalidTypeTransform = 1 // 无效转化
        case unsupportType = 2 // 不支持的类型
        case decodingError = 3 // 解码错误
        case encodingError = 4 // 编码错误
        case invalidUTF8String = 6 // 无效的UTF8字符
        case jsonObjectError = 7 // JSONObject错误
    }

    /// 可能是系统抛出也可能是本工具抛出的错误
    var error: Error?
    /// 错误码
    var errorCode: ErrorCode?

    /// 类型不支持
    static func unsupportType() -> CodingError {
        return CodingError(errorCode: .unsupportType)
    }

    /// 无效的json
    static func invalidJSON() -> CodingError {
        return CodingError(errorCode: .invalidJSON)
    }

    /// 转化失败
    static func invalidTypeTransform() -> CodingError {
        return CodingError(errorCode: .invalidTypeTransform)
    }

    struct Decoding {
        static func typeMismatch(type: Any.Type, codingPath: [CodingKey] = [], reality: JSON) -> CodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Expected to decode \(type) but found \(reality)) instead.")
            return CodingError(error: DecodingError.typeMismatch(type, context), errorCode: .decodingError)
        }

        static func numberMisfit(type: Any.Type, codingPath: [CodingKey] = [] , reality: CustomStringConvertible) -> CodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Parsed JSON number <\(reality)> does not fit in \(type).")
            return CodingError(error: DecodingError.dataCorrupted(context), errorCode: .decodingError)
        }

        static func valueNotFound(type: Any.Type, codingPath: [CodingKey] = []) -> CodingError {
            let error = DecodingError.valueNotFound(JSON.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
            return CodingError(error: error, errorCode: CodingError.ErrorCode.decodingError)
        }
    }

    struct Encoding {
        static func invalidValue(value: Any?, codingPath: [CodingKey]) -> CodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Attempt to encode value through single value container when previously value already encoded.")
            return CodingError(error: EncodingError.invalidValue(value as Any, context), errorCode: .encodingError)
        }

        static func invalidUTF8String(value: String) -> CodingError {
            debugPrint(value)
            return CodingError(errorCode: CodingError.ErrorCode.invalidUTF8String)
        }
    }

    /// JSON error转 CodingError
    static func jsonErrorToCodingError(error: JSON.Error) -> CodingError {
        return CodingError(error: error, errorCode: CodingError.ErrorCode.jsonObjectError)
    }
}




