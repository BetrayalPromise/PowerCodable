import Foundation

struct DecodingSingleValue: SingleValueDecodingContainer {
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }

    private unowned let decoder: PowerInnerJSONDecoder
    private let json: JSON

    init(decoder: PowerInnerJSONDecoder, json: JSON) {
        self.json = json
        self.decoder = decoder
    }

    func decodeNil() -> Bool {
        if self.decoder.wrapper?.customNilToOptionalType ?? false {
            return false
        }
        return decoder.unboxNil(object: json)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int.Type) throws -> Int {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Float.Type) throws -> Float {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Double.Type) throws -> Double {
        return try decoder.unbox(object: json)
    }

    func decode(_ type: String.Type) throws -> String {
        return try decoder.unbox(object: json)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        if type == URL.self {
            switch json {
            case .string(let string):
                do {
                    return try URL.buildURL(string: string) as! T
                } catch {
                    throw error
                }
            default:
                throw CodingError.invalidTypeTransform()
            }
        }
        return try decoder.unboxDecodable(object: json)
    }
}

//extension DecodingSingleValue {
//    func decode() throws -> Date {
//        switch self.decoder.wrapper?.dateDecodingStrategy ?? .utc {
//        case .deferredToDate, .utc: break
//
//        case .iso8601:
//            if #available(OSX 10.12, *) {
//                let formatter = ISO8601DateFormatter()
//                formatter.timeZone = TimeZone(secondsFromGMT: 0)
//                guard let string = self.json.string$, let date: Date = formatter.date(from: string) else {
//                    throw CodingError.invalidTypeTransform()
//                }
//                return date
//            } else {
//                let formatter = DateFormatter()
//                formatter.calendar = Calendar(identifier: .iso8601)
//                formatter.locale = Locale(identifier: "en_US_POSIX")
//                formatter.timeZone = TimeZone(secondsFromGMT: 0)
//                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
//                guard let string = self.json.string$, let date: Date = formatter.date(from: string) else {
//                    return Date()
//                }
//                return date
//            }
//        case .secondsSince1970: break
//        case .millisecondsSince1970: break
//        case .formatted(let formatter): break
//        case .custom(let closure): break
//        case .gmt: break
//        }
//        return Date()
//    }
//}
