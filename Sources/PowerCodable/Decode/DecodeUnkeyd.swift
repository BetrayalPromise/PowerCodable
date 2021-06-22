import Foundation

struct DecodeUnkeyed: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] {
        get { return self.inner.codingPath }
        set { self.inner.codingPath = newValue }
    }

    var count: Int? {
        return self.json.count
    }
    
    var isAtEnd: Bool {
        return self.currentIndex >= self.json.count
    }
    
    var currentIndex: Int = 0

    private unowned let inner: InnerDecoder
    private let json: [JSON]

    init(inner: InnerDecoder, json: [JSON]) {
        self.json = json
        self.inner = inner
    }

    private var currentKey: CodingKey {
        return Path.index(by: self.currentIndex)
    }

    @inline(__always)
    private mutating func getObject() throws -> JSON {
        guard !isAtEnd else { throw Coding.Exception.valueNotFound(type: JSON.self, codingPath: self.inner.codingPath + [currentKey]) }
        defer { self.currentIndex += 1 }
        return json[self.currentIndex]
    }
}

extension DecodeUnkeyed {
    var paths: [Path] {
        get { return self.inner.decoder?.paths ?? [] }
        set { self.inner.decoder?.paths = newValue }
    }
}

extension DecodeUnkeyed {
    mutating func decodeNil() throws -> Bool {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unboxNil(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode(_ type: String.Type) throws -> String {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey)
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        self.paths.push(value: Path.index(by: self.currentIndex), decoder: self.inner.decoder ?? PowerJSONDecoder())
        defer { self.paths.pop() }
        debugPrint(self.paths.path)
        return try self.inner.unbox(json: self.getObject(), forKey: self.currentKey, type: type)
    }
}

extension DecodeUnkeyed {
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(currentKey)
        defer { codingPath.removeLast() }
        return try self.inner.container(keyedBy: type, json: self.getObject())
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try self.inner.unkeyedContainer(json: self.getObject())
    }
}

extension DecodeUnkeyed {
    mutating func superDecoder() throws -> Decoder {
        return InnerDecoder(json: JSON.array(json), at: self.inner.codingPath, decoder: self.inner.decoder ?? PowerJSONDecoder())
    }
}
