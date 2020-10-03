import Foundation

struct PowerSingleValueDecodingContainer: SingleValueDecodingContainer {
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }

    private unowned let decoder: PowerInnerJSONDecoder
    private let object: JSON

    init(referencing decoder: PowerInnerJSONDecoder, wrapping object: JSON) {
        self.object = object
        self.decoder = decoder
    }

    func decodeNil() -> Bool {
        if self.decoder.wrapper?.customNilToOptionalType ?? false {
            return false
        }
        return decoder.unboxNil(object: object)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Int.Type) throws -> Int {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Float.Type) throws -> Float {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: Double.Type) throws -> Double {
        return try decoder.unbox(object: object)
    }

    func decode(_ type: String.Type) throws -> String {
        return try decoder.unbox(object: object)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        return try decoder.unboxDecodable(object: object)
    }
}
