import Foundation

class EncodingSingleValue: SingleValueEncodingContainer {
    fileprivate var canEncodeNewValue = true
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    fileprivate var storage: JSON = .null
    private unowned let encoder: PowerInnerJSONEncoder

    init(referencing encoder: PowerInnerJSONEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    fileprivate func checkCanEncode(value: Any?) throws {
        guard self.canEncodeNewValue else {
            let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Attempt to encode value through single value container when previously value already encoded.")
            throw EncodingError.invalidValue(value as Any, context)
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
        self.storage = .bool(value)
    }

    func encode(_ value: String) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        self.storage = .string(value)
    }

    func encode(_ value: Double) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        self.storage = .double(value)
    }

    func encode(_ value: Float) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        self.storage = .double(Double(value))
    }

    func encode(_ value: Int) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: Int8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: Int16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: Int32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: Int64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: UInt) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: UInt8) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: UInt16) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: UInt32) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode(_ value: UInt64) throws {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        self.storage = .integer(Int64(value))
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        let encoder = PowerInnerJSONEncoder()
        try value.encode(to: encoder)
        self.storage = encoder.jsonValue
    }
}

extension EncodingSingleValue: JSONValue {
    var jsonValue: JSON {
        return self.storage
    }
}
