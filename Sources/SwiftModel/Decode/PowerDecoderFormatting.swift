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
}

extension PowerJSONDecoder {
    public enum NonConformingFloatDecodingStrategy {
        /// 解码为0
        case convertToZero(positiveInfinity: Set<String> = ["infinity", "+infinity"], negativeInfinity: Set<String> = ["-infinity"], nan: Set<String> = ["nan"])
        /// 解码为制定一的字符串
        case convertToString(positiveInfinity: Set<String> = ["infinity", "+infinity"], negativeInfinity: Set<String> = ["-infinity"], nan: Set<String> = ["nan"])
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
