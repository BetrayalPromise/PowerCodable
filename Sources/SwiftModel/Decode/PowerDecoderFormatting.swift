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
        /// 抛出异常
        case `throw`
        /// 解码为0
        case zero
        /// 解码为制定一的字符串
        case convertToString(positiveInfinity: Set<String> = ["infinity", "+infinity"], negativeInfinity: Set<String> = ["-infinity"], nan: Set<String> = ["nan"])
    }
}

extension Set where Element == String {
    static let positiveInfinitys: Set<String> = ["infinity", "+infinity"]
    static let negativeInfinitys: Set<String> = ["-infinity"]
    static let nons: Set<String> = ["nan"]
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
