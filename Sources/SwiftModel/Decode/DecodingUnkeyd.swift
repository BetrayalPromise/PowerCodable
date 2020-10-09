import Foundation

struct DecodingUnkeyed: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }

    var count: Int? {
        return sequence.count
    }
    
    var isAtEnd: Bool {
        return currentIndex >= sequence.count
    }
    
    var currentIndex: Int

    private unowned let decoder: PowerInnerJSONDecoder
    private let sequence: [JSON]

    init(referencing decoder: PowerInnerJSONDecoder, wrapping container: [JSON]) {
        self.sequence = container
        self.decoder = decoder
        self.currentIndex = 0
    }

    private var currentKey: CodingKey {
        return PowerJSONKey(index: currentIndex)
    }

    @inline(__always)
    private mutating func getCurrentObject() throws -> JSON {
        guard !isAtEnd else {
            let context = DecodingError.Context(codingPath: decoder.codingPath + [currentKey], debugDescription: "Unkeyed container is at end.")
            throw DecodingError.valueNotFound(JSON.self, context)
        }
        defer { currentIndex += 1 }
        return sequence[currentIndex]
    }
}

extension DecodingUnkeyed {
    mutating func decodeNil() throws -> Bool {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unboxNil(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: String.Type) throws -> String {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        self.decoder.paths.push(value: Path.index(by: currentIndex))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unboxDecodable(object: getCurrentObject(), forKey: currentKey)
    }
}

extension DecodingUnkeyed {
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(currentKey)
        defer { codingPath.removeLast() }
        return try decoder.container(keyedBy: type, wrapping: getCurrentObject())
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try decoder.unkeyedContainer(wrapping: getCurrentObject())
    }
}

extension DecodingUnkeyed {
    mutating func superDecoder() throws -> Decoder {
        return PowerInnerJSONDecoder(referencing: JSON.array(sequence), at: decoder.codingPath)
    }
}
