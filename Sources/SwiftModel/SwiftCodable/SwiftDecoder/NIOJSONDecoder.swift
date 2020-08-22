import Foundation

/*
    JSON格式正确的格式只能有如下情况
    'STRING', 'NUMBER', 'NULL', 'TRUE', 'FALSE', '{}', '[]'
 */

/// 该操作为线程不安全操作 使用者可以自行加锁
public final class NIOJSONDecoder {
    /// 类型转换策略
    public var convertTypeStrategy: NIOJSONDecoder.ConvertTypeStrategy = .useDefaultable

    /// [:]出现键不匹配
    public var keyedKeyNotFoundStrategy: NIOJSONDecoder.KeyedDecoding.KeyNotFound = .useExecption

    /// [:]类型出现数据源的树形结构中某一个层级出现{}的情况
    public var keyedEmptyValueStrategy: NIOJSONDecoder.KeyedDecoding.EmptyValue = .useExecption

    /// [:]类型出现数据源的树形结构中某一个层级出现null的情况
    public var keyedNullValueStrategy: NIOJSONDecoder.KeyedDecoding.NullValue = .useExecption

    /// 简单可以理解为系统内建类型的之间转换出现键不匹配
    public var decodingSingleKeyNotFoundStrategy: NIOJSONDecoder.SingleDecoding.KeyNotFound = .useExecption

    /// null是否参与转换,只有该项先设置为true,再设置自定义转换,才有意义
    public var convertNullStrategy: Bool = false

    /// 内建类型(Bool, Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64, Float, Double, String)默认值自定义
    public var boxBaseValue: BoxBaseValue = BoxBaseValue()

    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - data: 数据源的二进制形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    public func decode<T>(type: T.Type, from data: Data) throws -> T? where T: Decodable {
        guard let source: Any = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: [], debugDescription: "无法转化为以Array或者Dictionary为根节点的JSON数据"))
        }
        let decoder: NIODecoder = NIODecoder(wrapper: self, source: source)
        defer { decoder.cleanup() }
        do {
            return try decoder.unbox(value: source, as: type, path: AbstractPath(codingKeys: decoder.codingPath))
        } catch {
            throw error
        }
    }

    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - string: 数据源的字符串形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    public func decode<T>(type: T.Type, from string: String) throws -> T? where T: Decodable {
        return try self.decode(type: type, from: string.data(using: String.Encoding.utf8) ?? "无法解析\(string)")
    }


    /// 模型转化
    /// - Parameters:
    ///   - type: 顶层模型类型
    ///   - object: 数据源的对象形式
    /// - Throws: 解析异常
    /// - Returns: 转换完成的模型
    public func decode<T>(type: T.Type, from object: Any) throws -> T? where T: Decodable {
        if JSONSerialization.isValidJSONObject(object) {
            let data: Data =  try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            return try self.decode(type: type, from: data)
        } else {
            throw DecodingError.typeMismatch(type, DecodingError.Context(codingPath: [], debugDescription: "无效的JSON数据"))
        }
    }
    
    public init() {}
}

/// 配置策略
public extension NIOJSONDecoder {
    /// 类型不一致策略
    enum ConvertTypeStrategy {
        case useDefaultable  // 默认处理
        case useCustom(TypeConvertible)  // 自定义处理
    }

    enum KeyedDecoding {
        // 处理空字典[:]
        public enum EmptyValue {
            case useExecption
            case useCustom(ValueControllable)
        }

        // 处理字典为null
        public enum NullValue {
            case useExecption
            case useCustom(ValueControllable)
        }

        /// 处理键不匹配 不包含上面俩中情况
        public enum KeyNotFound {
            case useCustom(KeyControllable)
            case useExecption
            case useDefaultable
            case useNull
        }
    }

    enum SingleDecoding {
        public enum KeyNotFound {
            case useCustom(KeyControllable)
            case useExecption
        }
    }
}
