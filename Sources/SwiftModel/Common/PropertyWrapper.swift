import Foundation

#if swift(>=5.1)
public struct Ignore: Codable {
    private static var optionalValue: Any? = nil
    private static var nonoptionalValue: Any = Null()

    @propertyWrapper
    public struct OptionalCoding<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType?

        public init(wrappedValue: WrappedType?) {
            self.wrappedValue = wrappedValue
            Ignore.optionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = Ignore.optionalValue as? WrappedType else { return }
            self.wrappedValue = value
        }

        public func encode(to encoder: Encoder) throws {}
    }

    @propertyWrapper
    public struct NonoptionalCoding<WrappedType: Codable>: Codable {
        public var wrappedValue: WrappedType

        public init(wrappedValue: WrappedType) {
            self.wrappedValue = wrappedValue
            Ignore.nonoptionalValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            guard let value = Ignore.nonoptionalValue as? WrappedType else {
                self.wrappedValue = try WrappedType.init(from: decoder)
                return
            }
            self.wrappedValue = value
        }

        public func encode(to encoder: Encoder) throws {}
    }
}

//public struct Base64: Codable {
//    @propertyWrapper
//    public struct EncodingToData<WrappedType: Codable>: Codable {
//        public var wrappedValue: WrappedType?
//
//        public init(from decoder: Decoder) throws {
//            guard let decoder = decoder as? PowerInnerJSONDecoder, let value: String = decoder.currentObject as? String else { return }
//            self.wrappedValue = Data(base64Encoded: value) as? WrappedType
//        }
//
//        public func encode(to encoder: Encoder) throws {}
//    }
//
//    @propertyWrapper
//    public struct EncodingToString<WrappedType: Codable>: Codable {
//        public var wrappedValue: WrappedType?
//
//        public init(from decoder: Decoder) throws {
//            guard let decoder = decoder as? PowerInnerJSONDecoder, let value: String = decoder.currentObject as? String else { return }
//            self.wrappedValue = String(data: Data(base64Encoded: value) ?? Data(), encoding: String.Encoding.utf8) as? WrappedType
//        }
//
//        public func encode(to encoder: Encoder) throws {}
//    }
//
//
//    @propertyWrapper
//    public struct DecodingToData<WrappedType: Codable>: Codable  {
//        public var wrappedValue: WrappedType?
//
//        public init(from decoder: Decoder) throws {
//            guard let decoder = decoder as? PowerInnerJSONDecoder else { return }
//            switch decoder.currentObject {
//            case .object(_):
//
//            case .array(_):
//
//            case .null:
//
//            case .bool(_):
//
//            case .string(_):
//
//            case .integer(_):
//
//            case .double(_):
//                
//            }
//            self.wrappedValue = value.data(using: String.Encoding.utf8)?.base64EncodedData() as? WrappedType
//        }
//
//        public func encode(to encoder: Encoder) throws {}
//    }
//
//    @propertyWrapper
//    public struct DecodingToString<WrappedType: Codable>: Codable {
//        public var wrappedValue: WrappedType?
//
//        public init(from decoder: Decoder) throws {
//            guard let decoder = decoder as? PowerInnerJSONDecoder, let value: String = decoder.currentObject as? String else { return }
//            let data: Data = value.data(using: String.Encoding.utf8)?.base64EncodedData() ?? Data()
//            self.wrappedValue = String(data: data, encoding: String.Encoding.utf8) as? WrappedType
//        }
//
//        public func encode(to encoder: Encoder) throws {}
//    }
//}
#endif



