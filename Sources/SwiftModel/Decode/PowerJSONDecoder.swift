import Foundation

public final class PowerJSONDecoder {
    /// 值转化策略
    public var valueConvertTypeStrategy: PowerJSONDecoder.ValueConvertTypeStrategy = .useDefaultable
    ///  nil转化为可选类型开关 如果开启的话 nil -> Type? 则不一定会生成 nil值 取决于用户自己根据需求
    public var customNilToOptionalType: Bool = false

    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - data: 数据源的二进制形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T>(type: T.Type, fromData: Data) throws -> T where T: Decodable {
        do {
            let rootObject: JSON = try JSON.Parser.parse(fromData)
            let decoder = PowerInnerJSONDecoder(referencing: rootObject)
            decoder.wrapper = self
            return try decoder.unboxDecodable(object: rootObject)
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON", underlyingError: error ))
        }
    }

    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - string: 数据源的字符串形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T>(type: T.Type, fromString: String) throws -> T? where T: Decodable {
        return try self.decode(type: type, fromData: (fromString.data(using: String.Encoding.utf8) ?? Data()))
    }

    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - object: 数据源的对象形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    func decode<T>(type: T.Type, fromObject: Any) throws -> T? where T: Decodable {
        if JSONSerialization.isValidJSONObject(fromObject) {
            let data: Data = try JSONSerialization.data(withJSONObject: fromObject, options: .prettyPrinted)
            return try self.decode(type: type, fromData: data)
        } else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: [], debugDescription: "无效的JSON数据"))
        }
    }
}

public extension PowerJSONDecoder {
    /// 类型不一致策略
    enum ValueConvertTypeStrategy {
        case useDefaultable
        case useCustom(TypeConvertible)
    }
}
