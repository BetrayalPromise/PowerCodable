import Foundation

//public typealias NIOCodingPath = String

/// 基础类型转换处理
public protocol TypeConvertible {
    // MARK: Bool
    func toBool(path: AbstractPath, value: NSNull) -> Bool
//    func toBoolIfPresent(path: AbstractPath, value: NSNull) -> Bool?

    func toBool(path: AbstractPath, value: Bool) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Bool) -> Bool?

    func toBool(path: AbstractPath, value: Int) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Int) -> Bool?

    func toBool(path: AbstractPath, value: Int8) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Int8) -> Bool?

    func toBool(path: AbstractPath, value: Int16) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Int16) -> Bool?

    func toBool(path: AbstractPath, value: Int32) -> Bool
    func toBooIIfPresent(path: AbstractPath, value: Int32) -> Bool?

    func toBool(path: AbstractPath, value: Int64) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Int64) -> Bool?

    func toBool(path: AbstractPath, value: UInt) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: UInt) -> Bool?

    func toBool(path: AbstractPath, value: UInt8) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: UInt8) -> Bool?

    func toBool(path: AbstractPath, value: UInt16) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: UInt16) -> Bool?

    func toBool(path: AbstractPath, value: UInt32) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: UInt32) -> Bool?


    func toBool(path: AbstractPath, value: UInt64) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: UInt64) -> Bool?

    func toBool(path: AbstractPath, value: Float) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Float) -> Bool?

    func toBool(path: AbstractPath, value: Double) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: Double) -> Bool?

    func toBool(path: AbstractPath, value: String) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: String) -> Bool?

    func toBool(path: AbstractPath, value: [AnyHashable: Any]) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Bool?

    func toBool(path: AbstractPath, value: [Any]) -> Bool
    func toBoolIfPresent(path: AbstractPath, value: [Any]) -> Bool?


    // MARK: - Int
    func toInt(path: AbstractPath, value: NSNull) -> Int
//    func toIntIfPresent(path: AbstractPath, value: NSNull) -> Int?

    func toInt(path: AbstractPath, value: Bool) -> Int
    func toIntIfPresent(path: AbstractPath, value: Bool) -> Int?

    func toInt(path: AbstractPath, value: Int) -> Int
    func toIntIfPresent(path: AbstractPath, value: Int) -> Int?

    func toInt(path: AbstractPath, value: Int8) -> Int
    func toIntIfPresent(path: AbstractPath, value: Int8) -> Int?

    func toInt(path: AbstractPath, value: Int16) -> Int
    func toIntIfPresent(path: AbstractPath, value: Int16) -> Int?

    func toInt(path: AbstractPath, value: Int32) -> Int
    func toIntIfPresent(path: AbstractPath, value: Int32) -> Int?

    func toInt(path: AbstractPath, value: Int64) -> Int
    func toIntIfPresent(path: AbstractPath, value: Int64) -> Int?

    func toInt(path: AbstractPath, value: UInt) -> Int
    func toIntIfPresent(path: AbstractPath, value: UInt) -> Int?

    func toInt(path: AbstractPath, value: UInt8) -> Int
    func toIntIfPresent(path: AbstractPath, value: UInt8) -> Int?

    func toInt(path: AbstractPath, value: UInt16) -> Int
    func toIntIfPresent(path: AbstractPath, value: UInt16) -> Int?

    func toInt(path: AbstractPath, value: UInt32) -> Int
    func toIntIfPresent(path: AbstractPath, value: UInt32) -> Int?

    func toInt(path: AbstractPath, value: UInt64) -> Int
    func toIntIfPresent(path: AbstractPath, value: UInt64) -> Int?

    func toInt(path: AbstractPath, value: Float) -> Int
    func toIntIfPresent(path: AbstractPath, value: Float) -> Int?

    func toInt(path: AbstractPath, value: Double) -> Int
    func toIntIfPresent(path: AbstractPath, value: Double) -> Int?

    func toInt(path: AbstractPath, value: String) -> Int
    func toIntIfPresent(path: AbstractPath, value: String) -> Int?

    func toInt(path: AbstractPath, value: [AnyHashable: Any]) -> Int
    func toIntIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int?

    func toInt(path: AbstractPath, value: [Any]) -> Int
    func toIntIfPresent(path: AbstractPath, value: [Any]) -> Int?

    // MARK:  - Int8
    func toInt8(path: AbstractPath, value: NSNull) -> Int8
//    func toInt8IfPresent(path: AbstractPath, value: NSNull) -> Int8?

    func toInt8(path: AbstractPath, value: Bool) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Bool) -> Int8?

    func toInt8(path: AbstractPath, value: Int) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Int) -> Int8?

    func toInt8(path: AbstractPath, value: Int8) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Int8) -> Int8?

    func toInt8(path: AbstractPath, value: Int16) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Int16) -> Int8?

    func toInt8(path: AbstractPath, value: Int32) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Int32) -> Int8?

    func toInt8(path: AbstractPath, value: Int64) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Int64) -> Int8?

    func toInt8(path: AbstractPath, value: UInt) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: UInt) -> Int8?

    func toInt8(path: AbstractPath, value: UInt8) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: UInt8) -> Int8?

    func toInt8(path: AbstractPath, value: UInt16) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: UInt16) -> Int8?

    func toInt8(path: AbstractPath, value: UInt32) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: UInt32) -> Int8?

    func toInt8(path: AbstractPath, value: UInt64) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: UInt64) -> Int8?

    func toInt8(path: AbstractPath, value: Float) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Float) -> Int8?

    func toInt8(path: AbstractPath, value: Double) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: Double) -> Int8?

    func toInt8(path: AbstractPath, value: String) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: String) -> Int8?

    func toInt8(path: AbstractPath, value: [AnyHashable: Any]) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int8?

    func toInt8(path: AbstractPath, value: [Any]) -> Int8
    func toInt8IfPresent(path: AbstractPath, value: [Any]) -> Int8?

    // MARK: - Int16
    func toInt16(path: AbstractPath, value: NSNull) -> Int16
//    func toInt16IfPresent(path: AbstractPath, value: NSNull) -> Int16?

    func toInt16(path: AbstractPath, value: Bool) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Bool) -> Int16?

    func toInt16(path: AbstractPath, value: Int) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Int) -> Int16?

    func toInt16(path: AbstractPath, value: Int8) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Int8) -> Int16?

    func toInt16(path: AbstractPath, value: Int16) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Int16) -> Int16?

    func toInt16(path: AbstractPath, value: Int32) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Int32) -> Int16?

    func toInt16(path: AbstractPath, value: Int64) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Int64) -> Int16?

    func toInt16(path: AbstractPath, value: UInt) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: UInt) -> Int16?

    func toInt16(path: AbstractPath, value: UInt8) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: UInt8) -> Int16?

    func toInt16(path: AbstractPath, value: UInt16) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: UInt16) -> Int16?

    func toInt16(path: AbstractPath, value: UInt32) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: UInt32) -> Int16?

    func toInt16(path: AbstractPath, value: UInt64) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: UInt64) -> Int16?

    func toInt16(path: AbstractPath, value: Float) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Float) -> Int16?

    func toInt16(path: AbstractPath, value: Double) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: Double) -> Int16?

    func toInt16(path: AbstractPath, value: String) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: String) -> Int16?

    func toInt16(path: AbstractPath, value: [AnyHashable: Any]) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int16?

    func toInt16(path: AbstractPath, value: [Any]) -> Int16
    func toInt16IfPresent(path: AbstractPath, value: [Any]) -> Int16?

    // MARK: - Int32
    func toInt32(path: AbstractPath, value: NSNull) -> Int32
//    func toInt32IfPresent(path: AbstractPath, value: NSNull) -> Int32?
    
    func toInt32(path: AbstractPath, value: Bool) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Bool) -> Int32?
    
    func toInt32(path: AbstractPath, value: Int) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Int) -> Int32?
    
    func toInt32(path: AbstractPath, value: Int8) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Int8) -> Int32?
    
    func toInt32(path: AbstractPath, value: Int16) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Int16) -> Int32?

    func toInt32(path: AbstractPath, value: Int32) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Int32) -> Int32?
    
    func toInt32(path: AbstractPath, value: Int64) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Int64) -> Int32?
    
    func toInt32(path: AbstractPath, value: UInt) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: UInt) -> Int32?
    
    func toInt32(path: AbstractPath, value: UInt8) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: UInt8) -> Int32?
    
    func toInt32(path: AbstractPath, value: UInt16) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: UInt16) -> Int32?
    
    func toInt32(path: AbstractPath, value: UInt32) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: UInt32) -> Int32?
    
    func toInt32(path: AbstractPath, value: UInt64) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: UInt64) -> Int32?
    
    func toInt32(path: AbstractPath, value: Float) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Float) -> Int32?
    
    func toInt32(path: AbstractPath, value: Double) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: Double) -> Int32?
    
    func toInt32(path: AbstractPath, value: String) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: String) -> Int32?

    func toInt32(path: AbstractPath, value: [AnyHashable: Any]) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int32?

    func toInt32(path: AbstractPath, value: [Any]) -> Int32
    func toInt32IfPresent(path: AbstractPath, value: [Any]) -> Int32?

    // MARK: - Int64
    func toInt64(path: AbstractPath, value: NSNull) -> Int64
//    func toInt64IfPresent(path: AbstractPath, value: NSNull) -> Int64?

    func toInt64(path: AbstractPath, value: Bool) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Bool) -> Int64?
    
    func toInt64(path: AbstractPath, value: Int) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Int) -> Int64?
    
    func toInt64(path: AbstractPath, value: Int8) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Int8) -> Int64?
    
    func toInt64(path: AbstractPath, value: Int16) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Int16) -> Int64?
    
    func toInt64(path: AbstractPath, value: Int32) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Int32) -> Int64?

    func toInt64(path: AbstractPath, value: Int64) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Int64) -> Int64?
    
    func toInt64(path: AbstractPath, value: UInt) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: UInt) -> Int64?
    
    func toInt64(path: AbstractPath, value: UInt8) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: UInt8) -> Int64?
    
    func toInt64(path: AbstractPath, value: UInt16) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: UInt16) -> Int64?
    
    func toInt64(path: AbstractPath, value: UInt32) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: UInt32) -> Int64?
    
    func toInt64(path: AbstractPath, value: UInt64) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: UInt64) -> Int64?
    
    func toInt64(path: AbstractPath, value: Float) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Float) -> Int64?
    
    func toInt64(path: AbstractPath, value: Double) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: Double) -> Int64?
    
    func toInt64(path: AbstractPath, value: String) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: String) -> Int64?

    func toInt64(path: AbstractPath, value: [AnyHashable: Any]) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int64?

    func toInt64(path: AbstractPath, value: [Any]) -> Int64
    func toInt64IfPresent(path: AbstractPath, value: [Any]) -> Int64?

    // MARK: - UInt
    func toUInt(path: AbstractPath, value: NSNull) -> UInt
//    func toUIntIfPresent(path: AbstractPath, value: NSNull) -> UInt?

    func toUInt(path: AbstractPath, value: Bool) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Bool) -> UInt?
    
    func toUInt(path: AbstractPath, value: Int) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Int) throws -> UInt?
    
    func toUInt(path: AbstractPath, value: Int8) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Int8) throws ->  UInt?
    
    func toUInt(path: AbstractPath, value: Int16) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Int16) throws -> UInt?
    
    func toUInt(path: AbstractPath, value: Int32) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Int32) throws -> UInt?
    
    func toUInt(path: AbstractPath, value: Int64) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Int64) throws -> UInt?

    func toUInt(path: AbstractPath, value: UInt) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: UInt) -> UInt?
    
    func toUInt(path: AbstractPath, value: UInt8) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: UInt8) -> UInt?
    
    func toUInt(path: AbstractPath, value: UInt16) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: UInt16) -> UInt?
    
    func toUInt(path: AbstractPath, value: UInt32) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: UInt32) -> UInt?
    
    func toUInt(path: AbstractPath, value: UInt64) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: UInt64) -> UInt?
    
    func toUInt(path: AbstractPath, value: Float) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Float) throws -> UInt?
    
    func toUInt(path: AbstractPath, value: Double) throws -> UInt
    func toUIntIfPresent(path: AbstractPath, value: Double) throws -> UInt?
    
    func toUInt(path: AbstractPath, value: String) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: String) -> UInt?

    func toUInt(path: AbstractPath, value: [AnyHashable: Any]) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt?

    func toUInt(path: AbstractPath, value: [Any]) -> UInt
    func toUIntIfPresent(path: AbstractPath, value: [Any]) -> UInt?

    // MARK: - UInt8
    func toUInt8(path: AbstractPath, value: NSNull) -> UInt8
//    func toUInt8IfPresent(path: AbstractPath, value: NSNull) -> UInt8?

    func toUInt8(path: AbstractPath, value: Bool) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Bool) -> UInt8?

    func toUInt8(path: AbstractPath, value: Int) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Int) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: Int8) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Int8) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: Int16) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Int16) throws -> UInt8?
    
    func toUInt8(path: AbstractPath, value: Int32) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Int32) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: Int64) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Int64) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: UInt) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: UInt) -> UInt8?

    func toUInt8(path: AbstractPath, value: UInt8) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: UInt8) -> UInt8?

    func toUInt8(path: AbstractPath, value: UInt16) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: UInt16) -> UInt8?

    func toUInt8(path: AbstractPath, value: UInt32) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: UInt32) -> UInt8?

    func toUInt8(path: AbstractPath, value: UInt64) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: UInt64) -> UInt8?

    func toUInt8(path: AbstractPath, value: Float) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Float) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: Double) throws -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: Double) throws -> UInt8?

    func toUInt8(path: AbstractPath, value: String) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: String) -> UInt8?

    func toUInt8(path: AbstractPath, value: [AnyHashable: Any]) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt8?

    func toUInt8(path: AbstractPath, value: [Any]) -> UInt8
    func toUInt8IfPresent(path: AbstractPath, value: [Any]) -> UInt8?

    // MARK: - UInt16
    func toUInt16(path: AbstractPath, value: NSNull) -> UInt16
//    func toUInt16IfPresent(path: AbstractPath, value: NSNull) -> UInt16?

    func toUInt16(path: AbstractPath, value: Bool) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Bool) -> UInt16?

    func toUInt16(path: AbstractPath, value: Int) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Int) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: Int8) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Int8) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: Int16) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Int16) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: Int32) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Int32) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: Int64) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Int64) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: UInt) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: UInt) -> UInt16?

    func toUInt16(path: AbstractPath, value: UInt8) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: UInt8) -> UInt16?

    func toUInt16(path: AbstractPath, value: UInt16) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: UInt16) -> UInt16?

    func toUInt16(path: AbstractPath, value: UInt32) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: UInt32) -> UInt16?

    func toUInt16(path: AbstractPath, value: UInt64) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: UInt64) -> UInt16?

    func toUInt16(path: AbstractPath, value: Float) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Float) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: Double) throws -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: Double) throws -> UInt16?

    func toUInt16(path: AbstractPath, value: String) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: String) -> UInt16?

    func toUInt16(path: AbstractPath, value: [AnyHashable: Any]) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt16?

    func toUInt16(path: AbstractPath, value: [Any]) -> UInt16
    func toUInt16IfPresent(path: AbstractPath, value: [Any]) -> UInt16?

    // MARK: - UInt32
    func toUInt32(path: AbstractPath, value: NSNull) -> UInt32
//    func toUInt32IfPresent(path: AbstractPath, value: NSNull) -> UInt32?

    func toUInt32(path: AbstractPath, value: Bool) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Bool) -> UInt32?

    func toUInt32(path: AbstractPath, value: Int) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Int) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: Int8) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Int8) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: Int16) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Int16) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: Int32) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Int32) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: Int64) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Int64) throws ->  UInt32?

    func toUInt32(path: AbstractPath, value: UInt) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: UInt) -> UInt32?

    func toUInt32(path: AbstractPath, value: UInt8) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: UInt8) -> UInt32?

    func toUInt32(path: AbstractPath, value: UInt16) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: UInt16) -> UInt32?

    func toUInt32(path: AbstractPath, value: UInt32) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: UInt32) -> UInt32?

    func toUInt32(path: AbstractPath, value: UInt64) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: UInt64) -> UInt32?

    func toUInt32(path: AbstractPath, value: Float) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Float) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: Double) throws -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: Double) throws -> UInt32?

    func toUInt32(path: AbstractPath, value: String) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: String) -> UInt32?

    func toUInt32(path: AbstractPath, value: [AnyHashable: Any]) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt32?

    func toUInt32(path: AbstractPath, value: [Any]) -> UInt32
    func toUInt32IfPresent(path: AbstractPath, value: [Any]) -> UInt32?

    // MARK: - UInt64
    func toUInt64(path: AbstractPath, value: NSNull) -> UInt64
//    func toUInt64IfPresent(path: AbstractPath, value: NSNull) -> UInt64?

    func toUInt64(path: AbstractPath, value: Bool) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Bool) -> UInt64?

    func toUInt64(path: AbstractPath, value: Int) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Int) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: Int8) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Int8) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: Int16) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Int16) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: Int32) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Int32) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: Int64) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Int64) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: UInt) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: UInt) -> UInt64?

    func toUInt64(path: AbstractPath, value: UInt8) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: UInt8) -> UInt64?

    func toUInt64(path: AbstractPath, value: UInt16) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: UInt16) -> UInt64?

    func toUInt64(path: AbstractPath, value: UInt32) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: UInt32) -> UInt64?

    func toUInt64(path: AbstractPath, value: UInt64) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: UInt64) -> UInt64?

    func toUInt64(path: AbstractPath, value: Float) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Float) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: Double) throws -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: Double) throws -> UInt64?

    func toUInt64(path: AbstractPath, value: String) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: String) -> UInt64?

    func toUInt64(path: AbstractPath, value: [AnyHashable: Any]) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt64?

    func toUInt64(path: AbstractPath, value: [Any]) -> UInt64
    func toUInt64IfPresent(path: AbstractPath, value: [Any]) -> UInt64?

    // MARK: - Float
    func toFloat(path: AbstractPath, value: NSNull) -> Float
//    func toFloatIfPresent(path: AbstractPath, value: NSNull) -> Float?

    func toFloat(path: AbstractPath, value: Bool) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Bool) -> Float?

    func toFloat(path: AbstractPath, value: Int) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Int) -> Float?

    func toFloat(path: AbstractPath, value: Int8) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Int8) -> Float?

    func toFloat(path: AbstractPath, value: Int16) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Int16) -> Float?

    func toFloat(path: AbstractPath, value: Int32) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Int32) -> Float?

    func toFloat(path: AbstractPath, value: Int64) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Int64) -> Float?

    func toFloat(path: AbstractPath, value: UInt) -> Float
    func toFloatIfPresent(path: AbstractPath, value: UInt) -> Float?

    func toFloat(path: AbstractPath, value: UInt8) -> Float
    func toFloatIfPresent(path: AbstractPath, value: UInt8) -> Float?

    func toFloat(path: AbstractPath, value: UInt16) -> Float
    func toFloatIfPresent(path: AbstractPath, value: UInt16) -> Float?

    func toFloat(path: AbstractPath, value: UInt32) -> Float
    func toFloatIfPresent(path: AbstractPath, value: UInt32) -> Float?

    func toFloat(path: AbstractPath, value: UInt64) -> Float
    func toFloatIfPresent(path: AbstractPath, value: UInt64) -> Float?

    func toFloat(path: AbstractPath, value: Float) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Float) -> Float?

    func toFloat(path: AbstractPath, value: Double) -> Float
    func toFloatIfPresent(path: AbstractPath, value: Double) -> Float?

    func toFloat(path: AbstractPath, value: String) -> Float
    func toFloatIfPresent(path: AbstractPath, value: String) -> Float?

    func toFloat(path: AbstractPath, value: [AnyHashable: Any]) -> Float
    func toFloatIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Float?

    func toFloat(path: AbstractPath, value: [Any]) -> Float
    func toFloatIfPresent(path: AbstractPath, value: [Any]) -> Float?

    // MARK: - Double
    func toDouble(path: AbstractPath, value: NSNull) ->  Double
//    func toDoubleIfPresent(path: AbstractPath, value: NSNull) ->  Double?

    func toDouble(path: AbstractPath, value: Bool) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Bool) -> Double?

    func toDouble(path: AbstractPath, value: Int) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Int) -> Double?

    func toDouble(path: AbstractPath, value: Int8) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Int8) -> Double?

    func toDouble(path: AbstractPath, value: Int16) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Int16) -> Double?

    func toDouble(path: AbstractPath, value: Int32) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Int32) -> Double?

    func toDouble(path: AbstractPath, value: Int64) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Int64) -> Double?

    func toDouble(path: AbstractPath, value: UInt) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: UInt) -> Double?

    func toDouble(path: AbstractPath, value: UInt8) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: UInt8) -> Double?

    func toDouble(path: AbstractPath, value: UInt16) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: UInt16) -> Double?

    func toDouble(path: AbstractPath, value: UInt32) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: UInt32) -> Double?

    func toDouble(path: AbstractPath, value: UInt64) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: UInt64) -> Double?

    func toDouble(path: AbstractPath, value: Float) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Float) -> Double?

    func toDouble(path: AbstractPath, value: Double) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: Double) -> Double?

    func toDouble(path: AbstractPath, value: String) -> Double
    func toDoubleIfPresent(path: AbstractPath, value: String) -> Double?

    func toDouble(path: AbstractPath, value: [AnyHashable: Any]) ->  Double
    func toDoubleIfPresent(path: AbstractPath, value: [AnyHashable: Any]) ->  Double?

    func toDouble(path: AbstractPath, value: [Any]) ->  Double
    func toDoubleIfPresent(path: AbstractPath, value: [Any]) ->  Double?

    // MARK: - String
    func toString(path: AbstractPath, value: NSNull) -> String
//    func toStringIfPresent(path: AbstractPath, value: NSNull) -> String?

    func toString(path: AbstractPath, value: Bool) -> String
    func toStringIfPresent(path: AbstractPath, value: Bool) -> String?

    func toString(path: AbstractPath, value: Int) -> String
    func toStringIfPresent(path: AbstractPath, value: Int) -> String?

    func toString(path: AbstractPath, value: Int8) -> String
    func toStringIfPresent(path: AbstractPath, value: Int8) -> String?

    func toString(path: AbstractPath, value: Int16) -> String
    func toStringIfPresent(path: AbstractPath, value: Int16) -> String?

    func toString(path: AbstractPath, value: Int32) -> String
    func toStringIfPresent(path: AbstractPath, value: Int32) -> String?

    func toString(path: AbstractPath, value: Int64) -> String
    func toStringIfPresent(path: AbstractPath, value: Int64) -> String?

    func toString(path: AbstractPath, value: UInt) -> String
    func toStringIfPresent(path: AbstractPath, value: UInt) -> String?

    func toString(path: AbstractPath, value: UInt8) -> String
    func toStringIfPresent(path: AbstractPath, value: UInt8) -> String?

    func toString(path: AbstractPath, value: UInt16) -> String
    func toStringIfPresent(path: AbstractPath, value: UInt16) -> String?

    func toString(path: AbstractPath, value: UInt32) -> String
    func toStringIfPresent(path: AbstractPath, value: UInt32) -> String?

    func toString(path: AbstractPath, value: UInt64) -> String
    func toStringIfPresent(path: AbstractPath, value: UInt64) -> String?

    func toString(path: AbstractPath, value: Float) -> String
    func toStringIfPresent(path: AbstractPath, value: Float) -> String?

    func toString(path: AbstractPath, value: Double) -> String
    func toStringIfPresent(path: AbstractPath, value: Double) -> String?

    func toString(path: AbstractPath, value: String) -> String
    func toStringIfPresent(path: AbstractPath, value: String) -> String?

    func toString(path: AbstractPath, value: [AnyHashable: Any]) -> String
    func toStringIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> String?

    func toString(path: AbstractPath, value: [Any]) -> String
    func toStringIfPresent(path: AbstractPath, value: [Any]) -> String?
}

// MARK: - BOOL -
extension TypeConvertible {
    // MARK: NSNull -> Bool
    func toBool(path: AbstractPath, value: NSNull) -> Bool {
        return false
    }

//    func toBoolIfPresent(path: AbstractPath, value: NSNull) -> Bool? {
//        return nil
//    }

    // MARK: Bool -> Bool
    func toBool(path: AbstractPath, value: Bool) -> Bool {
        return value
    }

    func toBoolIfPresent(path: AbstractPath, value: Bool) -> Bool? {
        return value
    }

    // MARK: Int -> Bool
    func toBool(path: AbstractPath, value: Int) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Int) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: Int8 -> Bool
    func toBool(path: AbstractPath, value: Int8) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Int8) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: Int16 -> Bool
    func toBool(path: AbstractPath, value: Int16) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }
    func toBoolIfPresent(path: AbstractPath, value: Int16) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: Int32 -> Bool
    func toBool(path: AbstractPath, value: Int32) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBooIIfPresent(path: AbstractPath, value: Int32) -> Bool? {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Int32) -> Bool? {
        switch value {
        case 1: return true
        default: return false
        }
    }

    // MARK: Int64 -> Bool
    func toBool(path: AbstractPath, value: Int64) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Int64) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: UInt -> Bool
    func toBool(path: AbstractPath, value: UInt) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: UInt) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: UInt8 -> Bool
    func toBool(path: AbstractPath, value: UInt8) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: UInt8) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: UInt16 -> Bool
    func toBool(path: AbstractPath, value: UInt16) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: UInt16) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: UInt32 -> Bool
    func toBool(path: AbstractPath, value: UInt32) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: UInt32) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: UInt64 -> Bool
    func toBool(path: AbstractPath, value: UInt64) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: UInt64) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: Float -> Bool
    func toBool(path: AbstractPath, value: Float) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Float) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: Double -> Bool
    func toBool(path: AbstractPath, value: Double) -> Bool {
        switch value {
        case 1: return true
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: Double) -> Bool? {
        switch value {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }

    // MARK: String -> Bool
    func toBool(path: AbstractPath, value: String) -> Bool {
        switch value.lowercased() {
        case "true": return true
        case "false": return false
        default: return false
        }
    }

    func toBoolIfPresent(path: AbstractPath, value: String) -> Bool? {
        switch value.lowercased() {
        case "true": return true
        case "false": return false
        default: return nil
        }
    }

    // MARK: Dictionary -> Bool
    func toBool(path: AbstractPath, value: [AnyHashable: Any]) -> Bool {
        return false
    }

    func toBoolIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Bool? {
        return nil
    }

    // MARK: Array -> Bool
    func toBool(path: AbstractPath, value: [Any]) -> Bool {
        return false
    }

    func toBoolIfPresent(path: AbstractPath, value: [Any]) -> Bool? {
        return nil
    }
}

// MARK: - INT -
extension TypeConvertible {
    // MARK: NSNull -> Int
    func toInt(path: AbstractPath, value: NSNull) -> Int {
        return 0
    }

//    func toIntIfPresent(path: AbstractPath, value: NSNull) -> Int? {
//        return nil
//    }

    // MARK: Bool -> Int
    func toInt(path: AbstractPath, value: Bool) -> Int {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toIntIfPresent(path: AbstractPath, value: Bool) -> Int? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Int
    func toInt(path: AbstractPath, value: Int) -> Int {
        return value
    }

    func toIntIfPresent(path: AbstractPath, value: Int) -> Int? {
        return value
    }

    // MARK: Int8 -> Int
    func toInt(path: AbstractPath, value: Int8) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Int8) -> Int? {
        return Int(value)
    }

    // MARK: Int16 -> Int
    func toInt(path: AbstractPath, value: Int16) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Int16) -> Int? {
        return Int(value)
    }

    // MARK: Int32 -> Int
    func toInt(path: AbstractPath, value: Int32) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Int32) -> Int? {
        return Int(value)
    }

    // MARK: Int64 -> Int
    func toInt(path: AbstractPath, value: Int64) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Int64) -> Int? {
        return Int(value)
    }

    // MARK: UInt -> Int
    func toInt(path: AbstractPath, value: UInt) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: UInt) -> Int? {
        return Int(value)
    }

    // MARK: UInt8 -> Int
    func toInt(path: AbstractPath, value: UInt8) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: UInt8) -> Int? {
        return Int(value)
    }

    // MARK: UInt16 -> Int
    func toInt(path: AbstractPath, value: UInt16) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: UInt16) -> Int? {
        return Int(value)
    }

    // MARK: UInt32 -> Int
    func toInt(path: AbstractPath, value: UInt32) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: UInt32) -> Int? {
        return Int(value)
    }

    // MARK: UInt64 -> Int
    func toInt(path: AbstractPath, value: UInt64) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: UInt64) -> Int? {
        return Int(value)
    }

    // MARK: Float -> Int
    func toInt(path: AbstractPath, value: Float) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Float) -> Int? {
        return Int(value)
    }

    // MARK: Double -> Int
    func toInt(path: AbstractPath, value: Double) -> Int {
        return Int(value)
    }

    func toIntIfPresent(path: AbstractPath, value: Double) -> Int? {
        return Int(value)
    }

    // MARK: String -> Int
    func toInt(path: AbstractPath, value: String) -> Int {
        switch value.lowercased() {
        case "true", "yes": return 1
        case "false", "no": return 0
        default:
            return Int(value) ?? 0
        }
    }

    func toIntIfPresent(path: AbstractPath, value: String) -> Int? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int(value)
        }
    }

    // MARK: Dictionary -> Int
    func toInt(path: AbstractPath, value: [AnyHashable: Any]) -> Int {
        return 0
    }

    func toIntIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int? {
        return nil
    }

    // MARK: Array -> Int
    func toInt(path: AbstractPath, value: [Any]) -> Int {
        return 0
    }

    func toIntIfPresent(path: AbstractPath, value: [Any]) -> Int? {
        return nil
    }
}

// MARK: - INT8 -
extension TypeConvertible {
    // MARK: NSNull -> Int8
    func toInt8(path: AbstractPath, value: NSNull) -> Int8 {
        return 0
    }

//    func toInt8IfPresent(path: AbstractPath, value: NSNull) -> Int8? {
//        return nil
//    }

    // MARK: Bool -> Int8
    func toInt8(path: AbstractPath, value: Bool) -> Int8 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toInt8IfPresent(path: AbstractPath, value: Bool) -> Int8? {
        switch value {
        case true: return 1
        case false: return 0
        }
    }

    // MARK: Int -> Int8
    func toInt8(path: AbstractPath, value: Int) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Int) -> Int8? {
        return Int8(value)
    }

    // MARK: Int8 -> Int8
    func toInt8(path: AbstractPath, value: Int8) -> Int8 {
        return value
    }

    func toInt8IfPresent(path: AbstractPath, value: Int8) -> Int8? {
        return value
    }

    // MARK: Int16 -> Int8
    func toInt8(path: AbstractPath, value: Int16) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Int16) -> Int8? {
        return Int8(value)
    }

    // MARK: Int32 -> Int8
    func toInt8(path: AbstractPath, value: Int32) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Int32) -> Int8? {
        return Int8(value)
    }

    // MARK: Int64 -> Int8
    func toInt8(path: AbstractPath, value: Int64) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Int64) -> Int8? {
        return Int8(value)
    }

    // MARK: UInt -> Int8
    func toInt8(path: AbstractPath, value: UInt) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: UInt) -> Int8? {
        return Int8(value)
    }

    // MARK: UInt8 -> Int8
    func toInt8(path: AbstractPath, value: UInt8) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: UInt8) -> Int8? {
        return Int8(value)
    }

    // MARK: UInt16 -> Int8
    func toInt8(path: AbstractPath, value: UInt16) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: UInt16) -> Int8? {
        return Int8(value)
    }

    // MARK: UInt32 -> Int8
    func toInt8(path: AbstractPath, value: UInt32) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: UInt32) -> Int8? {
        return Int8(value)
    }

    // MARK: UInt64 -> Int8
    func toInt8(path: AbstractPath, value: UInt64) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: UInt64) -> Int8? {
        return Int8(value)
    }

    // MARK: Float -> Int8
    func toInt8(path: AbstractPath, value: Float) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Float) -> Int8? {
        return Int8(value)
    }

    // MARK: Double -> Int8
    func toInt8(path: AbstractPath, value: Double) -> Int8 {
        return Int8(value)
    }

    func toInt8IfPresent(path: AbstractPath, value: Double) -> Int8? {
        return Int8(value)
    }

    // MARK: String -> Int8
    func toInt8(path: AbstractPath, value: String) -> Int8 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int8(value) ?? 0
        }
    }

    func toInt8IfPresent(path: AbstractPath, value: String) -> Int8? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int8(value)
        }
    }

    // MARK: Dictionary -> Int8
    func toInt8(path: AbstractPath, value: [AnyHashable: Any]) -> Int8 {
        return 0
    }

    func toInt8IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int8? {
        return nil
    }

    // MARK: Array -> Int8
    func toInt8(path: AbstractPath, value: [Any]) -> Int8 {
        return 0
    }

    func toInt8IfPresent(path: AbstractPath, value: [Any]) -> Int8? {
        return nil
    }
}

// MARK: - INT16 -
extension TypeConvertible {
    // MARK: NSNull -> Int16
    func toInt16(path: AbstractPath, value: NSNull) -> Int16 {
        return 0
    }

//    func toInt16IfPresent(path: AbstractPath, value: NSNull) -> Int16? {
//        return nil
//    }

    // MARK: Bool -> Int16
    func toInt16(path: AbstractPath, value: Bool) -> Int16 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toInt16IfPresent(path: AbstractPath, value: Bool) -> Int16? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Int16
    func toInt16(path: AbstractPath, value: Int) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Int) -> Int16? {
        return Int16(value)
    }

    // MARK: Int8 -> Int16
    func toInt16(path: AbstractPath, value: Int8) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Int8) -> Int16? {
        return Int16(value)
    }

    // MARK: Int32 -> Int16
    func toInt16(path: AbstractPath, value: Int32) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Int32) -> Int16? {
        return Int16(value)
    }
    
    // MARK: Int16 -> Int16
    func toInt16(path: AbstractPath, value: Int16) -> Int16 {
        return value
    }

    func toInt16IfPresent(path: AbstractPath, value: Int16) -> Int16? {
        return value
    }

    // MARK: Int32 -> Int16?
    func toInt16(key: CodingKey, path: AbstractPath, value: Int32) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(key: CodingKey, path: AbstractPath, value: Int32) -> Int16? {
        return Int16(value)
    }

    // MARK: Int64 -> Int16
    func toInt16(path: AbstractPath, value: Int64) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Int64) -> Int16? {
        return Int16(value)
    }

    // MARK: UInt -> Int16
    func toInt16(path: AbstractPath, value: UInt) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: UInt) -> Int16? {
        return Int16(value)
    }

    // MARK: UInt8 -> Int16
    func toInt16(path: AbstractPath, value: UInt8) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: UInt8) -> Int16? {
        return Int16(value)
    }

    // MARK: UInt16 -> Int16
    func toInt16(path: AbstractPath, value: UInt16) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: UInt16) -> Int16? {
        return Int16(value)
    }

    // MARK: UInt32 -> Int16
    func toInt16(path: AbstractPath, value: UInt32) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: UInt32) -> Int16? {
        return Int16(value)
    }

    // MARK: UInt64 -> Int16
    func toInt16(path: AbstractPath, value: UInt64) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: UInt64) -> Int16? {
        return Int16(value)
    }

    // MARK: Float -> Int16
    func toInt16(path: AbstractPath, value: Float) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Float) -> Int16? {
        return Int16(value)
    }

    // MARK: Double -> Int16
    func toInt16(path: AbstractPath, value: Double) -> Int16 {
        return Int16(value)
    }

    func toInt16IfPresent(path: AbstractPath, value: Double) -> Int16? {
        return Int16(value)
    }

    // MARK: String -> Int16
    func toInt16(path: AbstractPath, value: String) -> Int16 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int16(value) ?? 0
        }
    }

    func toInt16IfPresent(path: AbstractPath, value: String) -> Int16? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int16(value)
        }
    }

    // MARK: Dictionary -> Int16
    func toInt16(path: AbstractPath, value: [AnyHashable: Any]) -> Int16 {
        return 0
    }

    func toInt16IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int16? {
        return nil
    }

    // MARK: Array -> Int16
    func toInt16(path: AbstractPath, value: [Any]) -> Int16 {
        return 0
    }

    func toInt16IfPresent(path: AbstractPath, value: [Any]) -> Int16? {
        return nil
    }
}

// MARK: - INT32 -
extension TypeConvertible {
    // MARK: NSNull -> Int32
    func toInt32(path: AbstractPath, value: NSNull) -> Int32 {
        return 0
    }

//    func toInt32IfPresent(path: AbstractPath, value: NSNull) -> Int32? {
//        return nil
//    }

    // MARK: Bool -> Int32
    func toInt32(path: AbstractPath, value: Bool) -> Int32 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toInt32IfPresent(path: AbstractPath, value: Bool) -> Int32? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Int32
    func toInt32(path: AbstractPath, value: Int) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Int) -> Int32? {
        return Int32(value)
    }

    // MARK: Int8 -> Int32
    func toInt32(path: AbstractPath, value: Int8) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Int8) -> Int32? {
        return Int32(value)
    }

    // MARK: Int16 -> Int32
    func toInt32(path: AbstractPath, value: Int16) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Int16) -> Int32? {
        return Int32(value)
    }

    // MARK: Int32 -> Int32
    func toInt32(path: AbstractPath, value: Int32) -> Int32 {
        return value
    }

    func toInt32IfPresent(path: AbstractPath, value: Int32) -> Int32? {
        return value
    }

    // MARK: Int64 -> Int32
    func toInt32(path: AbstractPath, value: Int64) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Int64) -> Int32? {
        return Int32(value)
    }

    // MARK: UInt -> Int32
    func toInt32(path: AbstractPath, value: UInt) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: UInt) -> Int32? {
        return Int32(value)
    }

    // MARK: UInt8 -> Int32
    func toInt32(path: AbstractPath, value: UInt8) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: UInt8) -> Int32? {
        return Int32(value)
    }

    // MARK: UInt16 -> Int32
    func toInt32(path: AbstractPath, value: UInt16) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: UInt16) -> Int32? {
        return Int32(value)
    }

    // MARK: UInt32 -> Int32
    func toInt32(path: AbstractPath, value: UInt32) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: UInt32) -> Int32? {
        return Int32(value)
    }

    // MARK: UInt64 -> Int32
    func toInt32(path: AbstractPath, value: UInt64) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: UInt64) -> Int32? {
        return Int32(value)
    }

    // MARK: Float -> Int32
    func toInt32(path: AbstractPath, value: Float) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Float) -> Int32? {
        return Int32(value)
    }

    // MARK: Double -> Int32
    func toInt32(path: AbstractPath, value: Double) -> Int32 {
        return Int32(value)
    }

    func toInt32IfPresent(path: AbstractPath, value: Double) -> Int32? {
        return Int32(value)
    }

    // MARK: String -> Int32
    func toInt32(path: AbstractPath, value: String) -> Int32 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int32(value) ?? 0
        }
    }

    func toInt32IfPresent(path: AbstractPath, value: String) -> Int32? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int32(value)
        }
    }

    // MARK: Dictionary -> Int32
    func toInt32(path: AbstractPath, value: [AnyHashable: Any]) -> Int32 {
        return 0
    }

    func toInt32IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int32? {
        return nil
    }

    // MARK: Array -> Int32
    func toInt32(path: AbstractPath, value: [Any]) -> Int32 {
        return 0
    }

    func toInt32IfPresent(path: AbstractPath, value: [Any]) -> Int32? {
        return nil
    }
}

// MARK: - INT64 -
extension TypeConvertible {
    // MARK: NSNull -> Int64
    func toInt64(path: AbstractPath, value: NSNull) -> Int64 {
        return 0
    }

//    func toInt64IfPresent(path: AbstractPath, value: NSNull) -> Int64? {
//        return nil
//    }

    // MARK: Bool -> Int64
    func toInt64(path: AbstractPath, value: Bool) -> Int64 {
        switch value {
        case true: return 1
        default: return 0
        }
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Bool) -> Int64? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Int64
    func toInt64(path: AbstractPath, value: Int) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Int) -> Int64? {
        return Int64(value)
    }

    // MARK: Int8 -> Int64
    func toInt64(path: AbstractPath, value: Int8) -> Int64 {
        return Int64(value)
    }

    func toInt64IfPresent(path: AbstractPath, value: Int8) -> Int64? {
        return Int64(value)
    }

    // MARK: Int16 -> Int64
    func toInt64(path: AbstractPath, value: Int16) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Int16) -> Int64? {
        return Int64(value)
    }

    // MARK: Int32 -> Int64
    func toInt64(path: AbstractPath, value: Int32) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Int32) -> Int64? {
        return Int64(value)
    }

    // MARK: Int64 -> Int64
    func toInt64(path: AbstractPath, value: Int64) -> Int64 {
        return value
    }

    func toInt64IfPresent(path: AbstractPath, value: Int64) -> Int64? {
        return value
    }

    // MARK: UInt -> Int64
    func toInt64(path: AbstractPath, value: UInt) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: UInt) -> Int64? {
        return Int64(value)
    }

    // MARK: UInt8 -> Int64
    func toInt64(path: AbstractPath, value: UInt8) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: UInt8) -> Int64? {
        return Int64(value)
    }

    // MARK: UInt16 -> Int64
    func toInt64(path: AbstractPath, value: UInt16) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: UInt16) -> Int64? {
        return Int64(value)
    }

    // MARK: UInt32 -> Int64
    func toInt64(path: AbstractPath, value: UInt32) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: UInt32) -> Int64? {
        return Int64(value)
    }

    // MARK: UInt64 -> Int64
    func toInt64(path: AbstractPath, value: UInt64) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: UInt64) -> Int64? {
        return Int64(value)
    }

    // MARK: Float -> Int64
    func toInt64(path: AbstractPath, value: Float) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Float) -> Int64? {
        return Int64(value)
    }

    // MARK: Double -> Int64
    func toInt64(path: AbstractPath, value: Double) -> Int64 {
        return Int64(value)
    }
    
    func toInt64IfPresent(path: AbstractPath, value: Double) -> Int64? {
        return Int64(value)
    }
    // MARK: String -> Int64
    func toInt64(path: AbstractPath, value: String) -> Int64 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int64(value) ?? 0
        }
    }

    func toInt64IfPresent(path: AbstractPath, value: String) -> Int64? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Int64(value)
        }
    }

    // MARK: Dictionay -> Int64
    func toInt64(path: AbstractPath, value: [AnyHashable: Any]) -> Int64 {
        return 0
    }

    func toInt64IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> Int64? {
        return nil
    }

    // MARK: Array -> Int64
    func toInt64(path: AbstractPath, value: [Any]) -> Int64 {
        return 0
    }

    func toInt64IfPresent(path: AbstractPath, value: [Any]) -> Int64? {
        return nil
    }
}

// MARK: - UINT -
extension TypeConvertible {
    // MARK: NSNull -> UInt
    func toUInt(path: AbstractPath, value: NSNull) -> UInt {
        return 0
    }

//    func toUIntIfPresent(path: AbstractPath, value: NSNull) -> UInt? {
//        return nil
//    }

    // MARK: Bool -> UInt
    func toUInt(path: AbstractPath, value: Bool) -> UInt {
        switch value {
        case true: return 1
        default: return 0
        }
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Bool) -> UInt? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> UInt
    func toUInt(path: AbstractPath, value: Int) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Int) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(UInt.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: Int8 -> UInt
    func toUInt(path: AbstractPath, value: Int8) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Int8) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: Int16 -> UInt
    func toUInt(path: AbstractPath, value: Int16) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Int16) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: Int32 -> UInt
    func toUInt(path: AbstractPath, value: Int32) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    func toUIntIfPresent(path: AbstractPath, value: Int32) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: Int64 -> UInt
    func toUInt(path: AbstractPath, value: Int64) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Int64) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: UInt -> UInt
    func toUInt(path: AbstractPath, value: UInt) -> UInt {
        return value
    }

    func toUIntIfPresent(path: AbstractPath, value: UInt) -> UInt? {
        return value
    }

    // MARK: UInt8 -> UInt
    func toUInt(path: AbstractPath, value: UInt8) -> UInt {
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: UInt8) -> UInt? {
        return UInt(value)
    }

    // MARK: UInt16 -> UInt
    func toUInt(path: AbstractPath, value: UInt16) -> UInt {
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: UInt16) -> UInt? {
        return UInt(value)
    }

    // MARK: UInt32 -> UInt
    func toUInt(path: AbstractPath, value: UInt32) -> UInt {
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: UInt32) -> UInt? {
        return UInt(value)
    }

    // MARK: UInt64 -> UInt
    func toUInt(path: AbstractPath, value: UInt64) -> UInt {
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: UInt64) -> UInt? {
        return UInt(value)
    }

    // MARK: Float -> UInt
    func toUInt(path: AbstractPath, value: Float) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Float) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: Double -> UInt
    func toUInt(path: AbstractPath, value: Double) throws -> UInt {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }
    
    func toUIntIfPresent(path: AbstractPath, value: Double) throws -> UInt? {
        if value < 0 { throw DecodingError.typeMismatch(Int8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt cant't transform to negative")) }
        return UInt(value)
    }

    // MARK: String -> UInt
    func toUInt(path: AbstractPath, value: String) -> UInt {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return 0
        }
    }
    
    func toUIntIfPresent(path: AbstractPath, value: String) -> UInt? {
        switch value.lowercased() {
        case "true", "yes": return 1
        case "false", "no": return 0
        default: return UInt(value.lowercased())
        }
    }

    // MARK: Dictionary -> UInt
    func toUInt(path: AbstractPath, value: [AnyHashable: Any]) -> UInt {
        return 0
    }

    func toUIntIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt? {
        return nil
    }

    // MARK: Array -> UInt
    func toUInt(path: AbstractPath, value: [Any]) -> UInt {
        return 0
    }

    func toUIntIfPresent(path: AbstractPath, value: [Any]) -> UInt? {
        return nil
    }
}

// MARK: - UInt8 -
extension TypeConvertible {
    // MARK: NSNull -> UInt8
    func toUInt8(path: AbstractPath, value: NSNull) -> UInt8 {
        return 0
    }

//    func toUInt8IfPresent(path: AbstractPath, value: NSNull) -> UInt8? {
//        return nil
//    }

    func toUInt8(path: AbstractPath, value: Bool) -> UInt8 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toUInt8IfPresent(path: AbstractPath, value: Bool) -> UInt8? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> UInt8
    func toUInt8(path: AbstractPath, value: Int) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Int) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: Int8 -> UInt8
    func toUInt8(path: AbstractPath, value: Int8) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Int8) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: Int16 -> UInt8
    func toUInt8(path: AbstractPath, value: Int16) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Int16) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: Int32 -> UInt8
    func toUInt8(path: AbstractPath, value: Int32) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Int32) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }
    // MARK: Int64 -> UInt8
    func toUInt8(path: AbstractPath, value: Int64) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Int64) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: UInt -> UInt8
    func toUInt8(path: AbstractPath, value: UInt) -> UInt8 {
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: UInt) -> UInt8? {
        return UInt8(value)
    }

    // MARK: UInt8 -> UInt8
    func toUInt8(path: AbstractPath, value: UInt8) -> UInt8 {
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: UInt8) -> UInt8? {
        return value
    }

    // MARK: UInt16 -> UInt8
    func toUInt8(path: AbstractPath, value: UInt16) -> UInt8 {
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: UInt16) -> UInt8? {
        return UInt8(value)
    }

    // MARK: UInt32 -> UInt8
    func toUInt8(path: AbstractPath, value: UInt32) -> UInt8 {
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: UInt32) -> UInt8? {
        return UInt8(value)
    }

    // MARK: UInt64 -> UInt8
    func toUInt8(path: AbstractPath, value: UInt64) -> UInt8 {
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: UInt64) -> UInt8? {
        return UInt8(value)
    }

    // MARK: Float -> UInt8
    func toUInt8(path: AbstractPath, value: Float) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Float) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: Double -> UInt8
    func toUInt8(path: AbstractPath, value: Double) throws -> UInt8 {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    func toUInt8IfPresent(path: AbstractPath, value: Double) throws -> UInt8? {
        if value < 0 { throw DecodingError.typeMismatch(UInt8.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt8 cant't transform to negative")) }
        return UInt8(value)
    }

    // MARK: String -> UInt8
    func toUInt8(path: AbstractPath, value: String) -> UInt8 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt8(value.lowercased()) ?? 0
        }
    }

    func toUInt8IfPresent(path: AbstractPath, value: String) -> UInt8? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt8(value.lowercased())
        }
    }

    // MARK: Dictionary -> UInt8
    func toUInt8(path: AbstractPath, value: [AnyHashable: Any]) -> UInt8 {
        return 0
    }

    func toUInt8IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt8? {
        return nil
    }

    // MARK: Array -> UInt8
    func toUInt8(path: AbstractPath, value: [Any]) -> UInt8 {
        return 0
    }

    func toUInt8IfPresent(path: AbstractPath, value: [Any]) -> UInt8? {
        return nil
    }
}

// MARK: - UInt16 -
extension TypeConvertible {
    // MARK: NSNull -> UInt16
    func toUInt16(path: AbstractPath, value: NSNull) -> UInt16 {
        return 0
    }

//    func toUInt16IfPresent(path: AbstractPath, value: NSNull) -> UInt16? {
//        return nil
//    }

    // MARK: Bool -> UInt16
    func toUInt16(path: AbstractPath, value: Bool) -> UInt16 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toUInt16IfPresent(path: AbstractPath, value: Bool) -> UInt16? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> UInt16
    func toUInt16(path: AbstractPath, value: Int) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Int) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: Int8 -> UInt16
    func toUInt16(path: AbstractPath, value: Int8) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Int8) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: Int16 -> UInt16
    func toUInt16(path: AbstractPath, value: Int16) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Int16) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: Int32 -> UInt16
    func toUInt16(path: AbstractPath, value: Int32) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Int32) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: Int64 -> UInt16
    func toUInt16(path: AbstractPath, value: Int64) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Int64) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: UInt -> UInt16
    func toUInt16(path: AbstractPath, value: UInt) -> UInt16 {
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: UInt) -> UInt16? {
        return UInt16(value)
    }

    // MARK: UInt8 -> UInt16
    func toUInt16(path: AbstractPath, value: UInt8) -> UInt16 {
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: UInt8) -> UInt16? {
        return UInt16(value)
    }

    // MARK: UInt16 -> UInt16
    func toUInt16(path: AbstractPath, value: UInt16) -> UInt16 {
        return value
    }

    func toUInt16IfPresent(path: AbstractPath, value: UInt16) -> UInt16? {
        return value
    }

    // MARK: UInt32 -> UInt16
    func toUInt16(path: AbstractPath, value: UInt32) -> UInt16 {
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: UInt32) -> UInt16? {
        return UInt16(value)
    }

    // MARK: UInt64 -> UInt16
    func toUInt16(path: AbstractPath, value: UInt64) -> UInt16 {
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: UInt64) -> UInt16? {
        return UInt16(value)
    }

    // MARK: Float -> UInt16
    func toUInt16(path: AbstractPath, value: Float) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Float) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

// MARK: Double -> UInt16
    func toUInt16(path: AbstractPath, value: Double) throws -> UInt16 {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    func toUInt16IfPresent(path: AbstractPath, value: Double) throws -> UInt16? {
        if value < 0 { throw DecodingError.typeMismatch(UInt16.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt16 cant't transform to negative")) }
        return UInt16(value)
    }

    // MARK: String -> UInt16
    func toUInt16(path: AbstractPath, value: String) -> UInt16 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt16(value.lowercased()) ?? 0
        }
    }

    func toUInt16IfPresent(path: AbstractPath, value: String) -> UInt16? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt16(value.lowercased())
        }
    }

    // MARK: Dictionary -> UInt16
    func toUInt16(path: AbstractPath, value: [AnyHashable: Any]) -> UInt16 {
        return 0
    }

    func toUInt16IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt16? {
        return nil
    }

    // MARK: Array -> UInt16
    func toUInt16(path: AbstractPath, value: [Any]) -> UInt16 {
        return 0
    }

    func toUInt16IfPresent(path: AbstractPath, value: [Any]) -> UInt16? {
        return nil
    }
}

// MARK: - UInt32 -
extension TypeConvertible {
    // MARK: NSNull -> UInt32
    func toUInt32(path: AbstractPath, value: NSNull) -> UInt32 {
        return 0
    }

//    func toUInt32IfPresent(path: AbstractPath, value: NSNull) -> UInt32? {
//        return nil
//    }

    // MARK: String -> UInt32
    func toUInt32(path: AbstractPath, value: Bool) -> UInt32 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toUInt32IfPresent(path: AbstractPath, value: Bool) -> UInt32? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> UInt32
    func toUInt32(path: AbstractPath, value: Int) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Int) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: Int8 -> UInt32
    func toUInt32(path: AbstractPath, value: Int8) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Int8) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: Int16 -> UInt32
    func toUInt32(path: AbstractPath, value: Int16) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Int16) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: Int32 -> UInt32
    func toUInt32(path: AbstractPath, value: Int32) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Int32) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: Int64 -> UInt32
    func toUInt32(path: AbstractPath, value: Int64) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Int64) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: UInt -> UInt32
    func toUInt32(path: AbstractPath, value: UInt) -> UInt32 {
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: UInt) -> UInt32? {
        return UInt32(value)
    }

    // MARK: UInt8 -> UInt32
    func toUInt32(path: AbstractPath, value: UInt8) -> UInt32 {
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: UInt8) -> UInt32? {
        return UInt32(value)
    }

    // MARK: UInt16 -> UInt32
    func toUInt32(path: AbstractPath, value: UInt16) -> UInt32 {
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: UInt16) -> UInt32? {
        return UInt32(value)
    }

    // MARK: UInt32 -> UInt32
    func toUInt32(path: AbstractPath, value: UInt32) -> UInt32 {
        return value
    }

    func toUInt32IfPresent(path: AbstractPath, value: UInt32) -> UInt32? {
        return value
    }

    // MARK: UInt64 -> UInt32
    func toUInt32(path: AbstractPath, value: UInt64) -> UInt32 {
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: UInt64) -> UInt32? {
        return UInt32(value)
    }

    // MARK: Float -> UInt32
    func toUInt32(path: AbstractPath, value: Float) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Float) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: Double -> UInt32
    func toUInt32(path: AbstractPath, value: Double) throws -> UInt32 {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    func toUInt32IfPresent(path: AbstractPath, value: Double) throws -> UInt32? {
        if value < 0 { throw DecodingError.typeMismatch(UInt32.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt32 cant't transform to negative")) }
        return UInt32(value)
    }

    // MARK: String -> UInt32
    func toUInt32(path: AbstractPath, value: String) -> UInt32 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt32(value.lowercased()) ?? 0
        }
    }

    func toUInt32IfPresent(path: AbstractPath, value: String) -> UInt32? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt32(value.lowercased())
        }
    }

    // MARK: Dictionary -> UInt32
    func toUInt32(path: AbstractPath, value: [AnyHashable: Any]) -> UInt32 {
        return 0
    }

    func toUInt32IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt32? {
        return nil
    }

    // MARK: Array -> UInt32
    func toUInt32(path: AbstractPath, value: [Any]) -> UInt32 {
        return 0
    }

    func toUInt32IfPresent(path: AbstractPath, value: [Any]) -> UInt32? {
        return nil
    }
}

// MARK: - UInt64 -
extension TypeConvertible {
    // MARK: NSNull -> UInt64
    func toUInt64(path: AbstractPath, value: NSNull) -> UInt64 {
        return 0
    }

//    func toUInt64IfPresent(path: AbstractPath, value: NSNull) -> UInt64? {
//        return nil
//    }

    // MARK: Bool -> UInt64
    func toUInt64(path: AbstractPath, value: Bool) -> UInt64 {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toUInt64IfPresent(path: AbstractPath, value: Bool) -> UInt64? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> UInt64
    func toUInt64(path: AbstractPath, value: Int) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Int) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    // MARK: Int8 -> UInt64
    func toUInt64(path: AbstractPath, value: Int8) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Int8) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

// MARK: Int16 -> UInt64
    func toUInt64(path: AbstractPath, value: Int16) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Int16) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    // MARK: Int32 -> UInt64
    func toUInt64(path: AbstractPath, value: Int32) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Int32) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }
    // MARK: Int64 -> UInt64
    func toUInt64(path: AbstractPath, value: Int64) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Int64) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    // MARK: UInt -> UInt64
    func toUInt64(path: AbstractPath, value: UInt) -> UInt64 {
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: UInt) -> UInt64? {
        return UInt64(value)
    }

    // MARK: UInt8 -> UInt64
    func toUInt64(path: AbstractPath, value: UInt8) -> UInt64 {
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: UInt8) -> UInt64? {
        return UInt64(value)
    }

    // MARK: UInt16 -> UInt64
    func toUInt64(path: AbstractPath, value: UInt16) -> UInt64 {
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: UInt16) -> UInt64? {
        return UInt64(value)
    }

    // MARK: UInt32 -> UInt64
    func toUInt64(path: AbstractPath, value: UInt32) -> UInt64 {
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: UInt32) -> UInt64? {
        return UInt64(value)
    }

    // MARK: UInt64 -> UInt64
    func toUInt64(path: AbstractPath, value: UInt64) -> UInt64 {
        return value
    }

    func toUInt64IfPresent(path: AbstractPath, value: UInt64) -> UInt64? {
        return value
    }

    // MARK: Float -> UInt64
    func toUInt64(path: AbstractPath, value: Float) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Float) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    // MARK: Double -> UInt64
    func toUInt64(path: AbstractPath, value: Double) throws -> UInt64 {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    func toUInt64IfPresent(path: AbstractPath, value: Double) throws -> UInt64? {
        if value < 0 { throw DecodingError.typeMismatch(UInt64.self, DecodingError.Context(codingPath: path.codingKeys, debugDescription: "UInt64 cant't transform to negative")) }
        return UInt64(value)
    }

    // MARK: String -> UInt64
    func toUInt64(path: AbstractPath, value: String) -> UInt64 {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt64(value.lowercased()) ?? 0
        }
    }

    func toUInt64IfPresent(path: AbstractPath, value: String) -> UInt64? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return UInt64(value.lowercased())
        }
    }

    // MARK: Dictionary -> UInt64
    func toUInt64(path: AbstractPath, value: [AnyHashable: Any]) -> UInt64 {
        return 0
    }

    func toUInt64IfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> UInt64? {
        return nil
    }

    // MARK: Array -> UInt64
    func toUInt64(path: AbstractPath, value: [Any]) -> UInt64 {
        return 0
    }

    func toUInt64IfPresent(path: AbstractPath, value: [Any]) -> UInt64? {
        return nil
    }
}

// MARK: - Float -
extension TypeConvertible {
    // MARK: Bool -> Float
    func toFloat(path: AbstractPath, value: NSNull) ->  Float {
        return 0.0
    }

//    func toFloatIfPresent(path: AbstractPath, value: NSNull) ->  Float? {
//        return nil
//    }

    func toFloat(path: AbstractPath, value: Bool) -> Float {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toFloatIfPresent(path: AbstractPath, value: Bool) -> Float? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Float
    func toFloat(path: AbstractPath, value: Int) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Int) -> Float? {
        return Float(value)
    }

    // MARK: Int8 -> Float
    func toFloat(path: AbstractPath, value: Int8) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Int8) -> Float? {
        return Float(value)
    }

    // MARK: Int16 -> Float
    func toFloat(path: AbstractPath, value: Int16) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Int16) -> Float? {
        return Float(value)
    }

    // MARK: Int32 -> Float
    func toFloat(path: AbstractPath, value: Int32) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Int32) -> Float? {
        return Float(value)
    }

    // MARK: Int64 -> Float
    func toFloat(path: AbstractPath, value: Int64) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Int64) -> Float? {
        return Float(value)
    }

    // MARK: UInt -> Float
    func toFloat(path: AbstractPath, value: UInt) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: UInt) -> Float? {
        return Float(value)
    }

    // MARK: UInt8 -> Float
    func toFloat(path: AbstractPath, value: UInt8) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: UInt8) -> Float? {
        return Float(value)
    }

    // MARK: UInt16 -> Float
    func toFloat(path: AbstractPath, value: UInt16) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: UInt16) -> Float? {
        return Float(value)
    }

    // MARK: UInt32 -> Float
    func toFloat(path: AbstractPath, value: UInt32) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: UInt32) -> Float? {
        return Float(value)
    }

    // MARK: UInt64 -> Float
    func toFloat(path: AbstractPath, value: UInt64) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: UInt64) -> Float? {
        return Float(value)
    }

    // MARK: Float -> Float
    func toFloat(path: AbstractPath, value: Float) -> Float {
        return value
    }

    func toFloatIfPresent(path: AbstractPath, value: Float) -> Float? {
        return value
    }

    // MARK: Double -> Float
    func toFloat(path: AbstractPath, value: Double) -> Float {
        return Float(value)
    }

    func toFloatIfPresent(path: AbstractPath, value: Double) -> Float? {
        return Float(value)
    }

    // MARK: String -> Float
    func toFloat(path: AbstractPath, value: String) -> Float {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Float(value.lowercased()) ?? 0
        }
    }

    func toFloatIfPresent(path: AbstractPath, value: String) -> Float? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Float(value.lowercased())
        }
    }

    // MARK: Dictionary -> Float
    func toFloat(path: AbstractPath, value: [AnyHashable: Any]) ->  Float {
        return 0.0
    }
    func toFloatIfPresent(path: AbstractPath, value: [AnyHashable: Any]) ->  Float? {
        return nil
    }

    // MARK: Array -> Float
    func toFloat(path: AbstractPath, value: [Any]) ->  Float {
        return 0.0
    }

    func toFloatIfPresent(path: AbstractPath, value: [Any]) ->  Float? {
        return nil
    }
}

// MARK: - Double -
extension TypeConvertible {
    // MARK: NSNull -> Double
    func toDouble(path: AbstractPath, value: NSNull) ->  Double {
        return 0.0
    }

//    func toDoubleIfPresent(path: AbstractPath, value: NSNull) ->  Double? {
//        return nil
//    }

    // MARK: Bool -> Double
    func toDouble(path: AbstractPath, value: Bool) -> Double {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    func toDoubleIfPresent(path: AbstractPath, value: Bool) -> Double? {
        switch value {
        case true: return 1
        default: return 0
        }
    }

    // MARK: Int -> Double
    func toDouble(path: AbstractPath, value: Int) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Int) -> Double? {
        return Double(value)
    }

    // MARK: Int8 -> Double
    func toDouble(path: AbstractPath, value: Int8) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Int8) -> Double? {
        return Double(value)
    }

    // MARK: Int16 -> Double
    func toDouble(path: AbstractPath, value: Int16) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Int16) -> Double? {
        return Double(value)
    }

    // MARK: Int32 -> Double
    func toDouble(path: AbstractPath, value: Int32) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Int32) -> Double? {
        return Double(value)
    }

    // MARK: Int64 -> Double
    func toDouble(path: AbstractPath, value: Int64) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Int64) -> Double? {
        return Double(value)
    }

    // MARK: UInt -> Double
    func toDouble(path: AbstractPath, value: UInt) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: UInt) -> Double? {
        return Double(value)
    }

    // MARK: UInt8 -> Double
    func toDouble(path: AbstractPath, value: UInt8) -> Double {
        return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: UInt8) -> Double? {
          return Double(value)
    }

    // MARK: UInt16 -> Double
    func toDouble(path: AbstractPath, value: UInt16) -> Double {
          return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: UInt16) -> Double? {
          return Double(value)
    }

    // MARK: UInt32 -> Double
    func toDouble(path: AbstractPath, value: UInt32) -> Double {
          return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: UInt32) -> Double? {
          return Double(value)
    }

    // MARK: UInt64 -> Double
    func toDouble(path: AbstractPath, value: UInt64) -> Double {
          return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: UInt64) -> Double? {
          return Double(value)
    }

    // MARK: Float -> Double
    func toDouble(path: AbstractPath, value: Float) -> Double {
          return Double(value)
    }

    func toDoubleIfPresent(path: AbstractPath, value: Float) -> Double? {
          return Double(value)
    }

    // MARK: Double -> Double
    func toDouble(path: AbstractPath, value: Double) -> Double {
          return value
    }

    func toDoubleIfPresent(path: AbstractPath, value: Double) -> Double? {
          return value
    }

    // MARK: String -> Double
    func toDouble(path: AbstractPath, value: String) -> Double {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Double(value.lowercased()) ?? 0
        }
    }

    func toDoubleIfPresent(path: AbstractPath, value: String) -> Double? {
        switch value.lowercased() {
        case "true": return 1
        case "false": return 0
        default: return Double(value.lowercased())
        }
    }

    // MARK: Dictionary -> Double
    func toDouble(path: AbstractPath, value: [AnyHashable: Any]) ->  Double {
        return 0.0
    }
    func toDoubleIfPresent(path: AbstractPath, value: [AnyHashable: Any]) ->  Double? {
        return nil
    }

    // MARK: Array -> Double
    func toDouble(path: AbstractPath, value: [Any]) ->  Double {
        return 0.0
    }

    func toDoubleIfPresent(path: AbstractPath, value: [Any]) ->  Double? {
        return nil
    }
}

// MARK: - String -
extension TypeConvertible {
    // MARK: NSNull -> String
    func toString(path: AbstractPath, value: NSNull) -> String {
        return ""
    }

//    func toStringIfPresent(path: AbstractPath, value: NSNull) -> String? {
//        return nil
//    }

    // MARK: Bool -> String
    func toString(path: AbstractPath, value: Bool) -> String {
        switch value {
        case true: return "true"
        case false: return "false"
        }
    }

    func toStringIfPresent(path: AbstractPath, value: Bool) -> String? {
        switch value {
        case true: return "true"
        case false: return "false"
        }
    }

// MARK: Int -> String
    func toString(path: AbstractPath, value: Int) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Int) -> String? {
        return "\(value)"
    }

    // MARK: Int8 -> String
    func toString(path: AbstractPath, value: Int8) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Int8) -> String? {
        return "\(value)"
    }

    // MARK: Int16 -> String
    func toString(path: AbstractPath, value: Int16) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Int16) -> String? {
        return "\(value)"
    }

    // MARK: Int32 -> String
    func toString(path: AbstractPath, value: Int32) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Int32) -> String? {
        return "\(value)"
    }

    // MARK: Int64 -> String
    func toString(path: AbstractPath, value: Int64) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Int64) -> String? {
        return "\(value)"
    }

    // MARK: UInt -> String
    func toString(path: AbstractPath, value: UInt) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: UInt) -> String? {
        return "\(value)"
    }

    // MARK: UInt8 -> String
    func toString(path: AbstractPath, value: UInt8) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: UInt8) -> String? {
        return "\(value)"
    }

    // MARK: UInt16 -> String
    func toString(path: AbstractPath, value: UInt16) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: UInt16) -> String? {
        return "\(value)"
    }

    // MARK: UInt32 -> String
    func toString(path: AbstractPath, value: UInt32) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: UInt32) -> String? {
        return "\(value)"
    }

    // MARK: UInt64 -> String
    func toString(path: AbstractPath, value: UInt64) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: UInt64) -> String? {
        return "\(value)"
    }

    // MARK: Float -> String
    func toString(path: AbstractPath, value: Float) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Float) -> String? {
        return "\(value)"
    }

    // MARK: Double -> String
    func toString(path: AbstractPath, value: Double) -> String {
        return "\(value)"
    }

    func toStringIfPresent(path: AbstractPath, value: Double) -> String? {
        return "\(value)"
    }

    // MARK: String -> String
    func toString(path: AbstractPath, value: String) -> String {
        return value
    }

    func toStringIfPresent(path: AbstractPath, value: String) -> String? {
        return value
    }

    // MARK: Dictionary -> String
    func toString(path: AbstractPath, value: [AnyHashable: Any]) -> String {
        return ""
    }

    func toStringIfPresent(path: AbstractPath, value: [AnyHashable: Any]) -> String? {
        return nil
    }

    // MARK: Array -> String
    func toString(path: AbstractPath, value: [Any]) -> String {
        return ""
    }

    func toStringIfPresent(path: AbstractPath, value: [Any]) -> String? {
        return nil
    }
}

#if false
/// 用以处理数值类型一致 但是取值超出范围
protocol NIOSingleValueDecodingScopeExecptionConvertible: RawRepresentable, Codable where RawValue: Codable {
    /// 单值容器 便于数值异常处理
    /// - Parameter value: 异常数值
    init(with value: Decodable)
}

extension NIOSingleValueDecodingScopeExecptionConvertible {
    init(from decoder: Decoder) throws {
        let singleValueContainer: SingleValueDecodingContainer = try decoder.singleValueContainer()
        do {
            let decoded = try singleValueContainer.decode(RawValue.self)
            self = Self.init(rawValue: decoded) ?? Self.init(with: decoded)
        } catch {
            self = Self.init(with: 0)
        }
    }
}

// MARK: - 处理单值去值异常问题
/// 单值转换处理
public protocol MappingControllable {
    func scope(key: CodingKey) -> Set<AnyHashable>
    func execption(key: CodingKey, source: AnyHashable) -> AnyHashable
}
#endif

// MARK: - 处理模型与数据结构不匹配问题
/// 模型解析失败时 使用的构造器 在可能解析失败的模型中实现该协议 (enum, struc, class)中实现该协议
public protocol Initalizable {
    init(path: AbstractPath, source: Any)
}

public protocol KeyControllable {
    /// 数据源实际的定义路径
    /// - Parameter sourcePath: 定义的模型路径
    func key(sourcePath: AbstractPath) -> AbstractPath
}

extension KeyControllable {
    func key(sourcePath: AbstractPath) -> AbstractPath {
        return AbstractPath()
    }
}

public protocol ValueControllable {
    /// 返回自定义模型
    /// - Parameters:
    ///   - path: 数据源定义路径
    ///   - source: 原始值
    func nullValue(path: AbstractPath, source: Any) -> Initalizable

    /// 返回自定义模型
    /// - Parameters:
    ///   - path: 数据源定义路径
    ///   - source: 原始值
    func emptyValue(path: AbstractPath, source: Any) -> Initalizable
}

extension ValueControllable {
    func nullValue(path: AbstractPath, source: Any) -> Initalizable {
        return 0
    }

    func emptyValue(path: AbstractPath, source: Any) -> Initalizable {
        return 0
    }
}
