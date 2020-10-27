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
}

extension DecodingSingleValue {
    var paths: [Path] {
        get { return self.decoder.wrapper?.paths ?? [] }
        set { self.decoder.wrapper?.paths = newValue }
    }
}

extension DecodingSingleValue {
    func decodeNil() -> Bool {
        debugPrint(self.json)
        return decoder.unboxNil(object: json)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int.Type) throws -> Int {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Float.Type) throws -> Float {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: Double.Type) throws -> Double {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode(_ type: String.Type) throws -> String {
        debugPrint(self.json)
        return try decoder.unbox(object: json)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        debugPrint(self.json)
        if type == URL.self {
            switch self.json {
            case .unknow: throw CodingError.invalidTypeTransform()
            case .null:
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: Null()) as! T
                case .useCustomValues(delegete: let delegate):
                    if self.decoder.wrapper?.enableMappingEmptyValue ?? false {
                        return delegate.toData(path: self.paths.jsonPath, value: Null()) as! T
                    } else {
                        return self.decoder.toData(path: self.paths.jsonPath, value: Null()) as! T
                    }
                }
            case .bool(let bool):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: bool) as! T
                case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: bool) as! T
                }
            case .integer(let integer):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: integer) as! T
                case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: integer) as! T
                }
            case .double(let double):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: double) as! T
                case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: double) as! T
                }
            case .string(let string):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: string) as! T
                case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: string) as! T
                }
            case .object(let object):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                 case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: object) as! T
                 case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: object) as! T
                 }
            case .array(let array):
                switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                 case .useDefaultValues: return try self.decoder.toURL(path: self.paths.jsonPath, value: array) as! T
                 case .useCustomValues(delegete: let delegate): return try delegate.toURL(path: self.paths.jsonPath, value: array) as! T
                 }
            }
        } else if type == Date.self {
            switch self.json {
            case .unknow:
                throw CodingError.invalidTypeTransform()
            case .null:
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: Null()) as! T
                    }
                }
            case .bool(let bool):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: bool) as! T
                    }
                }
            case .string(let string):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: string) as! T
                    }
                }
            case .integer(let integer):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: integer) as! T
                    }
                }
            case .double(let double):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: double) as! T
                    }
                }
            case .object(let object):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: object) as! T
                    }
                }
            case .array(let array):
                switch self.decoder.wrapper?.strategy.dateValueMapping ?? .useTimestamp {
                case .useCostomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useTimestamp:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useUTC:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useISO8601:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toDate(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegete):
                        return delegete.toDate(path: self.paths.jsonPath, value: array) as! T
                    }
                }
            }
        } else if type == Data.self {
            switch self.json {
            case .null:
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: Null()) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: Null()) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: Null()) as! T
                    }
                }
            case .bool(let bool):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: bool) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: bool) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: bool) as! T
                    }
                }
            case .integer(let integer):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: integer) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: integer) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: integer) as! T
                    }
                }
            case .double(let double):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: double) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: double) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: double) as! T
                    }
                }
            case .string(let string):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: string) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: string) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: string) as! T
                    }
                }
            case .object(let object):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: object) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: object) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: object) as! T
                    }
                }
            case .array(let array):
                switch self.decoder.wrapper?.strategy.dataValueMapping ?? .useDefaultValues {
                case .useDefaultValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useHexadecimalValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useCustomValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: array) as! T
                    }
                case .useMemoryValues:
                    switch self.decoder.wrapper?.strategy.valueMapping ?? .useDefaultValues {
                    case .useDefaultValues:
                        return self.decoder.toData(path: self.paths.jsonPath, value: array) as! T
                    case .useCustomValues(delegete: let delegate):
                        return delegate.toData(path: self.paths.jsonPath, value: array) as! T
                    }
                }
            case .unknow:
                throw CodingError.invalidTypeTransform()
            }
        }
        return try decoder.unboxDecodable(object: json)
    }
}

