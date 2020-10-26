import Foundation

extension PowerJSONDecoder {
    public enum KeyDecodingStrategy {
        case useDefaultKeys
        case useSnakeKeys(StringCaseFormat.SnakeCase)
        case useCamelKeys(StringCaseFormat.CamelCase)
        case usePascalKeys(StringCaseFormat.PascalCase)
        case useUpperKeys
        case useLowerKeys
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
        case useCustomValues(delegete: DecodingValueMappable)
    }

    /// Data解码策略
    public enum DataDecodingStrategy {
        /// 默认处理字符串直接转Data, 其他类型则为Data()
        case useDefaultValues
        /// 十六进制的字符串,针对字符串处理
        case useHexadecimalValues
        /// 读取内存中的值, 所有类型都可以
        case useMemoryValues
        /// delegete指实现DecodingValueConvertible协议(类结构题枚举或者自定义的实体)
        case useCustomValues(delegete: DecodingValueMappable)
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
            throw CodingError.unsupportType()
        }
    }

    static func buildURL(string: String) throws -> Self {
        guard let url = URL(string: string) else { throw CodingError.invalidTypeTransform() }
        return url
    }
}
