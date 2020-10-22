import Foundation

class EncodingSingleValue: SingleValueEncodingContainer {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    fileprivate var storage: JSON = .unknow
    private unowned let encoder: PowerInnerJSONEncoder

    init(encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    func encodeNil() throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .null
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(nilLiteral: ()))
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
            self.storage = .null
        }
    }

    func encode(_ value: Bool) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .bool(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(booleanLiteral: value))
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
            self.storage = .bool(value)
        }
    }

    func encode(_ value: String) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .string(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(stringLiteral: value))
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
            self.storage = .string(value)
        }
    }

    func encode(_ value: Double) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .double(value)
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(floatLiteral: value))
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
            self.storage = .double(value)
        }
    }

    func encode(_ value: Float) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .double(Double(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(floatLiteral: Double(value)))
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
            self.storage = .double(Double(value))
        }
    }

    func encode(_ value: Int) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: value))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: Int8) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: Int16) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: Int32) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: Int64) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: UInt) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: UInt8) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: UInt16) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: UInt32) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode(_ value: UInt64) throws {
        guard let keyValue: MappingEncodingKeysValues = self.encoder.value as? MappingEncodingKeysValues else {
            self.storage = .integer(Int64(value))
            return
        }
        let json: JSON = type(of: keyValue).modelEncodingValues(path: self.encoder.paths.jsonPath, value: JSON(integerLiteral: IntegerLiteralType(value)))
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
            self.storage = .integer(Int64(value))
        }
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        if value is URL {
            guard let url = value as? URL else { throw CodingError.invalidTypeTransform() }
            let encoder = PowerInnerJSONEncoder(value: url.absoluteString, paths: self.encoder.paths)
            encoder.wrapper = self.encoder.wrapper
            encoder.keyEncodingStrategy = self.encoder.wrapper?.keyEncodingStrategy ?? .useDefaultCase
            try url.absoluteString.encode(to: encoder)
            self.storage = encoder.jsonValue
        } else {
            let encoder = PowerInnerJSONEncoder(value: value, paths: self.encoder.paths)
            encoder.wrapper = self.encoder.wrapper
            encoder.keyEncodingStrategy = self.encoder.wrapper?.keyEncodingStrategy ?? .useDefaultCase
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
