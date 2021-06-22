import Foundation

public struct Coding {
    struct Exception: Swift.Error {
        /// 可能是系统抛出也可能是本工具抛出的错误
        var error: Swift.Error?
        /// 错误码
        let code: ExecptionCode
    }
    
    public enum ExecptionCode {
        case data // 无效数据(json数据无效)
        case transform // 无效转化
        case typeMismatch // 类型不匹配
        case numberMisfit // 数字不陪跑
        case valueNotFound // 未发现值
        case utf8 // 无效的UTF8字符
        case unknow // 使用了JSON.unknow
        case rule // 数据不唯一(针对正无穷,负无穷,不存在定义标准有重合)
    }
}

extension Coding.Exception {
    /// 转化失败
    /// - Returns: 错误
    static func transform() -> Coding.Exception {
        return Coding.Exception(code: .transform)
    }

    /// 使用了JSON.unknow
    /// - Returns: 错误
    static func unknow() -> Coding.Exception {
        return Coding.Exception(code: .unknow)
    }

    /// 无效的二进制数据
    /// - Returns: 错误
    static func data() -> Coding.Exception {
        return Coding.Exception(code: .data)
    }
    
    /// 集合(无穷及不存在)定义冲突,标准不唯一(有相互重叠的部分)
    /// - Parameter sets: 标准集合定义...
    /// - Returns: 错误
    static func rule(sets: Set<String>...) -> Coding.Exception {
        debugPrint("Error: sets(\(sets) can not has intersection")
        return Coding.Exception(code: .rule)
    }

    static func numberMisfit(type: Any.Type, codingPath: [CodingKey] = [] , reality: CustomStringConvertible) -> Coding.Exception {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Parsed JSON number <\(reality)> does not fit in \(type).")
        return Coding.Exception(error: DecodingError.dataCorrupted(context), code: .numberMisfit)
    }

    static func valueNotFound(type: Any.Type, codingPath: [CodingKey] = []) -> Coding.Exception {
        let error = DecodingError.valueNotFound(JSON.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        return Coding.Exception(error: error, code: .valueNotFound)
    }

    static func utf8(value: String) -> Coding.Exception {
        debugPrint(value)
        return Coding.Exception(code: .utf8)
    }
}
