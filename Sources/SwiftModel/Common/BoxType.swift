import Foundation

/// 用以表示空值
public struct Null: Codable {

}

public struct BoxBool {
    let bool: Bool = false
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Bool, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxInt {
    let int: Int = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxInt8 {
    let int8: Int8 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int8, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxInt16 {
    let int16: Int16 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int16, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxInt32 {
    let int32: Int32 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int32, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxInt64 {
    let int64: Int64 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Int64, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxUInt {
    let uint: UInt = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxUInt8 {
    let uint8: UInt8 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt8, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxUInt16 {
    let uint16: UInt16 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt16, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxUInt32 {
    let uint32: UInt32 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt32, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxUInt64 {
    let uint64: UInt64 = 0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to UInt64, use 0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxFloat {
    let float: Float = 0.0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Float, use 0.0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxDouble {
    let double: Double = 0.0
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Double, use 0.0 as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxString {
    let string: String
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to String, or implement MappingDecodingValueConvertible Protocal method to handle")
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
        debugPrint("Error: \(json) can not transform to URL, use URL(string: \"\")! as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxDate {
    let date: Date = Date()
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Date, use Date() as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}

public struct BoxData {
    let data: Data = Data()
    let json: JSON
    init(json: JSON) {
        debugPrint("Error: \(json) can not transform to Data, use Data() as default, or implement MappingDecodingValueConvertible Protocal method to handle")
        self.json = json
    }
}
