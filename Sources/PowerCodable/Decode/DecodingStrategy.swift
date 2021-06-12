import Foundation

extension PowerJSONDecoder {
    public enum KeyDecodingStrategy {
        case useDefaultKeys
        case useSnakeKeys(StringCaseFormat.SnakeCase)
        case useCamelKeys(StringCaseFormat.CamelCase)
        case usePascalKeys(StringCaseFormat.PascalCase)
        case useUpperKeys
        case useLowerKeys
        case useCustom(([CodingKey]) -> CodingKey)
    }

    public enum NonConformingFloatDecodingStrategy {
        /// 解码为0
        case convertToZero(positiveInfinity: Set<String> = ["infinity", "+infinity"], negativeInfinity: Set<String> = ["-infinity"], nan: Set<String> = ["nan"])
        /// 解码为制定一的字符串
        case convertToString(positiveInfinity: Set<String> = ["infinity", "+infinity"], negativeInfinity: Set<String> = ["-infinity"], nan: Set<String> = ["nan"])
    }

    /// 类型不一致策略
    public enum ValueDecodingStrategy {
        /// 默认处理
        case useDefaultValues
        /// delegete指实现DecodingValueConvertible协议(类结构题枚举或者自定义的实体)
        case useCustomValues(delegete: DecodeValueMapping)
    }

    /// Data解码策略
    public enum DataDecodingStrategy {
        /// 默认处理字符串直接转Data, 其他类型则为Data()
        case useDefaultValues
        /// 十六进制的字符串,针对字符串处理
        case hexadecimalValues
        /// 读取内存中的值, 所有类型都可以
        case deferredToData
        /// base64编码过的数据
        case base64
        /// 自定义
        case custom((Decoder) throws -> Data)
    }

    /// JSON数据源中的时间戳位数
    public enum Timestamp {
        /// 10位
        case second
        /// 13位
        case millisecond
    }

    public enum DateDecodingStrategy {
        /// 时间戳秒数(数值或者字符串)转Date不会处理时区 json设置为数据源JSON给出的是秒还是毫秒, 但是最终都会转化为秒进行处理, 适用于时间精度为秒级别的
        case secondsSince1970(json: Timestamp = .second)
        case millisecondsSince1970(json: Timestamp = .millisecond)
        /// utc时间格式字符串转转Date
        case deferredToDate, utc
        /// iso8601时间格式字符串转转Date
        case iso8601
        /// 根据 valueMapping设定的值
        case custom((Decoder, [Path], DateConvertible) throws -> Date)
    }
}

public extension URL {
    init(from json: JSON) throws {
        switch json {
        case .string(let string):
            do {
                self = try URL.buildURL(string: string)
            } catch {
                throw error
            }
        default:
            throw Coding.Exception.invalidTransform()
        }
    }

    static func buildURL(string: String) throws -> Self {
        guard let url = URL(string: string) else { throw Coding.Exception.invalidTransform() }
        return url
    }
}
