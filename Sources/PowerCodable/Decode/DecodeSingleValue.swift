import Foundation

struct DecodeSingleValue: SingleValueDecodingContainer {
    var codingPath: [CodingKey] {
        get { return self.inner.codingPath }
        set { self.inner.codingPath = newValue }
    }

    private unowned let inner: InnerDecoder
    private let json: JSON

    init(inner: InnerDecoder, json: JSON) {
        self.json = json
        self.inner = inner
    }
}

extension DecodeSingleValue {
    var paths: [Path] {
        get { return self.inner.decoder?.paths ?? [] }
        set { self.inner.decoder?.paths = newValue }
    }
}

extension DecodeSingleValue {
    func decodeNil() -> Bool {
        debugPrint(self.json)
        return self.inner.unboxNil(json: self.json)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Int.Type) throws -> Int {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Float.Type) throws -> Float {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: Double.Type) throws -> Double {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode(_ type: String.Type) throws -> String {
        debugPrint(self.json)
        return try inner.unbox(json: self.json)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        debugPrint(self.json)
        if type == URL.self {
            switch self.inner.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues: return try InnerDecoder.toURL(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
            case .useCustomValues(delegete: let delegate):
                if (self.inner.decoder?.strategy.value.enableEmpty ?? false) && self.json == .null {
                    return try Swift.type(of: delegate).toURL(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                } else {
                    return try InnerDecoder.toURL(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                }
            }
        } else if type == Date.self {
            switch self.inner.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues: return try InnerDecoder.toDate(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
            case .useCustomValues(delegete: let delegate):
                if (self.inner.decoder?.strategy.value.enableEmpty ?? false) && self.json == .null {
                    return try Swift.type(of: delegate).toDate(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                } else {
                    return try InnerDecoder.toDate(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                }
            }
        } else if type == Data.self {
            switch self.inner.decoder?.strategy.value.mapping ?? .useDefaultValues {
            case .useDefaultValues: return try InnerDecoder.toData(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
            case .useCustomValues(delegete: let delegate):
                if (self.inner.decoder?.strategy.value.enableEmpty ?? false) && self.json == .null {
                    return try Swift.type(of: delegate).toData(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                } else {
                    return try InnerDecoder.toData(decoder: self.inner.decoder ?? PowerJSONDecoder(), paths: self.paths, json: self.json) as! T
                }
            }
        }
        return try inner.unbox(json: self.json, type: type)
    }
}

