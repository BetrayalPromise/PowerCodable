import Foundation

//extension PowerJSONDecoder {
//    public enum DateDecodingStrategy {
//        case deferredToDate, utc
//        case gmt
//        case secondsSince1970
//        case millisecondsSince1970
//        case iso8601
//        case formatted(DateFormatter)
//        case custom((Decoder) throws -> Date)
//    }
//}

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
    public enum NonConformingFloatEncodingStrategy {
        case `throw`
        case zero
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
