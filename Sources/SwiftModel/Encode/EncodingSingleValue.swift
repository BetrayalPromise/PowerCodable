import Foundation

class EncodingSingleValue: SingleValueEncodingContainer {
    fileprivate var canEncodeNewValue = true
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    fileprivate var storage: JSON = .unknow
    private unowned let encoder: PowerInnerJSONEncoder

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    fileprivate func checkCanEncode(value: Any?) throws {
        guard self.canEncodeNewValue else {
            throw CodingError.Encoding.invalidValue(value: value, codingPath: self.codingPath)
        }
    }

    func encodeNil() throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        self.storage = .null
    }

    func encode(_ value: Bool) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .bool(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(booleanLiteral: value))
        if json == JSON.defaultJSON() {
            self.storage = .bool(value)
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: String) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .string(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(stringLiteral: value))
        if json == JSON.defaultJSON() {
            self.storage = .string(value)
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Double) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .double(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(floatLiteral: value))
        if json == JSON.defaultJSON() {
            self.storage = .double(value)
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Float) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .double(Double(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(floatLiteral: Double(value)))
        if json == JSON.defaultJSON() {
            self.storage = .double(Double(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Int) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: value))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Int8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Int16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Int32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: Int64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: UInt) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
                guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: UInt8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: UInt16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: UInt32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode(_ value: UInt64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
        if json == JSON.defaultJSON() {
            self.storage = .integer(Int64(value))
            return
        }
        switch json {
        case .object(let object):
            self.storage = .object(object)
        case .array(let array):
            self.storage = .array(array)
        case .null:
            self.storage = .null
        case .bool(let bool):
            self.storage = .bool(bool)
        case .string(let string):
            self.storage = .string(string)
        case .integer(let integer):
            self.storage = .integer(integer)
        case .double(let double):
            self.storage = .double(double)
        case .unknow:
            throw CodingError.unknowJSON()
        }
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        if value is URL {
            guard let url = value as? URL else { throw CodingError.invalidTypeTransform() }
            let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths)
            try url.absoluteString.encode(to: encoder)
            self.storage = encoder.jsonValue
        } else {
            let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths)
            try value.encode(to: encoder)
            self.storage = encoder.jsonValue
        }
    }
}

extension EncodingSingleValue: JSONValue {
    var jsonValue: JSON {
        return self.storage
    }
}
