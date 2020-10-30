import Foundation

/// 用以表示空值
public struct Null: Codable {

}

public struct BoxBool {
    let bool: Bool = false
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Bool, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxInt {
    let int: Int = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxInt8 {
    let int8: Int8 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int8, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxInt16 {
    let int16: Int16 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int16, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxInt32 {
    let int32: Int32 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int32, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxInt64 {
    let int64: Int64 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int64, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxUInt {
    let uint: UInt = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxUInt8 {
    let uint8: UInt8 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt8, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxUInt16 {
    let uint16: UInt16 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt16, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxUInt32 {
    let uint32: UInt32 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt32, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxUInt64 {
    let uint64: UInt64 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt64, return 0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxFloat {
    let float: Float = 0.0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Float, return 0.0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxDouble {
    let double: Double = 0.0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Double, return 0.0 as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxString {
    let string: String
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to String, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
        switch json {
        case .unknow: self.string = "unknow"
        case .null: self.string = "null"
        case .bool(let bool): self.string = "\(bool)"
        case .integer(let integer): self.string = "\(integer)"
        case .double(let double): self.string = "\(double)"
        case .string(let string): self.string = string
        case .object(_): self.string = "[:]"
        case .array(_): self.string = "[]"
        }
    }
}

public struct BoxURL {
    let url: URL = URL(string: "")!
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to URL, return URL(string: \"\")! as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxDate {
    let date: Date = Date()
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Date, return Date() as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}

public struct BoxData {
    let data: Data = Data()
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Data, return Data() as default, or implement MappingDecodingValueConvertible Protocal method to custom")
        self.json = json
    }
}
