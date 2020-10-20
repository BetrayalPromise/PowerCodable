import Foundation

//extension PowerJSONDecoder {
//    public enum DateDecodingStrategy {
//        /// Defer to `Date` for decoding. This is the default strategy.
//        case deferredToDate
//        /// Decode the `Date` as a UNIX timestamp from a JSON number.
//        case secondsSince1970
//        /// Decode the `Date` as UNIX millisecond timestamp from a JSON number.
//        case millisecondsSince1970
//        /// Decode the `Date` as an ISO-8601-formatted string (in RFC 3339 format).
//        case iso8601
//        /// Decode the `Date` as a string parsed by the given formatter.
//        case formatted(DateFormatter)
//        /// Decode the `Date` as a custom value decoded by the given closure.
//        case custom((Decoder) throws -> Date)
//    }
//}

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
