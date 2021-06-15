import Foundation

class EncodeSingleValue: SingleValueEncodingContainer {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    fileprivate var storage: JSON = .unknow
    private unowned let encoder: InnerEncoder

    init(encoder: InnerEncoder, codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.userInfo = userInfo
    }
}

extension EncodeSingleValue {
    var paths: [Path] {
        get { return self.encoder.wrapper?.paths ?? [] }
        set { self.encoder.wrapper?.paths = newValue }
    }
}

extension EncodeSingleValue {
    func encodeNil() throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: BoxNull())
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: BoxNull())
        }
    }

    func encode(_ value: Bool) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        }
    }

    func encode(_ value: String) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        }
    }

    func encode(_ value: Double) throws {
        debugPrint(self.storage)
        if value.isNaN || value.isInfinite {
            switch self.encoder.wrapper?.strategy.nonConformingFloatValueStrategy ?? .convertToString() {
            case .throw: throw Coding.Exception.invalidValue(value: Float.self, codingPath: self.codingPath, reality: JSON(floatLiteral: FloatLiteralType(value)))
            case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if value.isNaN {
                    self.storage = JSON(stringLiteral: nan); return
                } else if value == Double.infinity {
                    self.storage = JSON(stringLiteral: positiveInfinity); return
                } else if value == -Double.infinity {
                    self.storage = JSON(stringLiteral: negativeInfinity); return
                }
            case .null: self.storage = .null; return
            case .bool(let bool): self.storage = .bool(bool); return
            case .integer(let integer): self.storage = .integer(integer); return
            case .double(let double): self.storage = .double(double); return
            case .string(let string): self.storage = .string(string); return
            case .array(let array): self.storage = .array(array); return
            case .object(let object): self.storage = .object(object); return
            }
        }
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        }
    }

    func encode(_ value: Float) throws {
        debugPrint(self.storage)
        if value.isNaN || value.isInfinite {
            switch self.encoder.wrapper?.strategy.nonConformingFloatValueStrategy ?? .convertToString() {
            case .throw: throw Coding.Exception.invalidValue(value: value, codingPath: self.codingPath, reality: JSON(floatLiteral: FloatLiteralType(value)))
            case .convertToString(positiveInfinity: let positiveInfinity, negativeInfinity: let negativeInfinity, nan: let nan):
                if value.isNaN {
                    self.storage = JSON(stringLiteral: nan); return
                } else if value == Float.infinity {
                    self.storage = JSON(stringLiteral: positiveInfinity); return
                } else if value == -Float.infinity {
                    self.storage = JSON(stringLiteral: negativeInfinity); return
                }
            case .null: self.storage = .null; return
            case .bool(let bool): self.storage = .bool(bool); return
            case .integer(let integer): self.storage = .integer(integer); return
            case .double(let double): self.storage = .double(double); return
            case .string(let string): self.storage = .string(string); return
            case .array(let array): self.storage = .array(array); return
            case .object(let object): self.storage = .object(object); return
            }
        }
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Double(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Double(value))
        }
    }

    func encode(_ value: Int) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: Int8) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: Int16) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: Int32) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: Int64) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: value)
        }
    }

    func encode(_ value: UInt) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: UInt8) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: UInt16) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: UInt32) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode(_ value: UInt64) throws {
        debugPrint(self.storage)
        switch self.encoder.wrapper?.strategy.valueStrategy ?? .useDefaultValues {
        case .useDefaultValues:
            self.storage = InnerEncoder.toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        case .useCustomValues(delegete: let delegete):
            self.storage = type(of: delegete).toJSON(decoder: self.encoder.wrapper ?? PowerJSONEncoder(), paths: self.paths, value: Int64(value))
        }
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        debugPrint(self.storage)
        if value is URL {
            guard let url = value as? URL else { throw Coding.Exception.invalidTransform() }
            let encoder = InnerEncoder(value: url.absoluteString)
            encoder.wrapper = self.encoder.wrapper
            try url.absoluteString.encode(to: encoder)
            self.storage = encoder.jsonValue
        } else {
            let encoder = InnerEncoder(value: value)
            encoder.wrapper = self.encoder.wrapper
            try value.encode(to: encoder)
            self.storage = encoder.jsonValue
        }
    }
}

extension EncodeSingleValue: JSONValue {
    var jsonValue: JSON {
        return self.storage
    }
}
