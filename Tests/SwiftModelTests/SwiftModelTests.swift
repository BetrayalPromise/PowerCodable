import XCTest
@testable import SwiftModel

final class SwiftModelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]

    /*
     Bool转化标准支持
     标准布尔值 (true false)
     字符串值 ("true" "false") 及其大小写混合
     数值 只支持 0 == false 1 == true 其他均为 false
     */

    // MARK: - Bool -
    func testBool() {
        if true {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, 6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], true)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], true)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], false)
                XCTAssertEqual(models[9], false)
                XCTAssertEqual(models[10], false)
                XCTAssertEqual(models[11], false)
                XCTAssertEqual(models[12], false)
                XCTAssertEqual(models[13], false)
                XCTAssertEqual(models[14], false)
                XCTAssertEqual(models[15], false)
                XCTAssertEqual(models[16], false)
                XCTAssertEqual(models[17], false)
                XCTAssertEqual(models[18], false)
                XCTAssertEqual(models[19], false)
                XCTAssertEqual(models[20], false)
            } catch {
                print(error.localizedDescription)
            }
        }

        if true {
            struct Adapter: ValueControllable {
                func keyedEmptyValue(path: AbstractPath, source: Any) -> Initalizable {
                    return false
                }
            }

            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, 6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.keyedEmptyValueStrategy = .useCustom(Adapter())
            do {
                guard let models: [Bool?] = try decoder.decode(type: [Bool?].self, from: data) else {
                    XCTAssertFalse(false)
                    return
                }
                XCTAssertEqual(models[0], true)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], true)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], false)
                XCTAssertEqual(models[9], false)
                XCTAssertEqual(models[10], false)
                XCTAssertEqual(models[11], false)
                XCTAssertEqual(models[12], false)
                XCTAssertEqual(models[13], false)
                XCTAssertEqual(models[14], false)
                XCTAssertEqual(models[15], false)
                XCTAssertEqual(models[16], false)
                XCTAssertEqual(models[17], false)
                XCTAssertEqual(models[18], false)
                XCTAssertEqual(models[19], false)
                XCTAssertEqual(models[20], false)
            } catch {
                XCTAssertFalse(false, error.localizedDescription)
                print(error.localizedDescription)
            }
        }


        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: NSNull) -> Bool {
                    print(path)
                    return true
                }
            }

            struct Root: Codable {
                let info: [info]?
            }
            struct info: Codable {
                let a: String
            }

            let data: Data = """
                {"info": null}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertNullStrategy = true
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: Root = try decoder.decode(type: Root.self, from: data) else { return }
                XCTAssertEqual(models.info?.count, nil)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: Bool) -> Bool {
                    print(path)
                    return true
                }
            }

            struct Root: Codable {
                let information: Bool
            }

            let data: Data = #"""
                {"information": true}
            """#.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: Root = try decoder.decode(type: Root.self, from: data) else { return }
                XCTAssertEqual(models.information, true)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: Bool) -> Bool {
                    print(path)
                    return true
                }
            }
            let data: Data = """
            [[true, true], [true, false], [false, true], [false, false]]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [[Bool]] = try decoder.decode(type: [[Bool]].self, from: data) else { return }
                XCTAssertEqual(models[0][0], true)
                XCTAssertEqual(models[0][1], true)
                XCTAssertEqual(models[1][0], true)
                XCTAssertEqual(models[1][1], true)
                XCTAssertEqual(models[2][0], true)
                XCTAssertEqual(models[2][1], true)
                XCTAssertEqual(models[3][0], true)
                XCTAssertEqual(models[3][1], true)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: Bool) -> Bool {
                    print(path)
                    return true
                }
            }
            struct Root: Codable {
                let value: Bool
            }
            let data: Data = """
            [[{"value": true}], [{"value": false}]]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [[Root]] = try decoder.decode(type: [[Root]].self, from: data) else { return }
                print(models)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: Bool) -> Bool {
                    print(path)
                    return true
                }
            }
            struct Root: Codable {
                let value: [Bool]
            }
            let data: Data = """
            [[{"value": [true, false]}], [{"value": [false, true]}]]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [[Root]] = try decoder.decode(type: [[Root]].self, from: data) else { return }
                print(models)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    // MARK: - Number -> Bool
    /// 默认处理 数字映射 1为 true 非1为false
    func testNumberToBool() {
        if true {
            let data: Data = """
            [0, 1, 2, 3, 4.5, 5.9, 100, 150, null]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Bool?] = try decoder.decode(type: [Bool?].self, from: data) else { return }
                XCTAssertEqual(models[0], false)
                XCTAssertEqual(models[1], true)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], false)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], nil)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            /// 自定义的具体处理
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: Int) -> Bool {
                    if value == 100 {
                        return true
                    }
                    return false
                }
                func toBool(path: AbstractPath, value: Float) -> Bool {
                    if value == 5.9 {
                        return true
                    }
                    return false
                }
                func toBool(path: AbstractPath, value: Double) -> Bool {
                    if value == 5.9 {
                        return true
                    }
                    return false
                }
            }
            let data: Data = """
            [0, 1, 2, 3, 4.5, 5.9, 100, 150, null]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], false)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], false)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], true)
                XCTAssertEqual(models[6], true)
                XCTAssertEqual(models[7], false)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    // MARK: - String -> Bool
    // 默认为 "true" 映射为true, 其他为false
    func testStringToBool() {
        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: String) -> Bool {
                    if value == "null" {
                        return true
                    }
                    return false
                }
            }
            let data: Data = """
            ["0", "1", "2", "3", "4.5", "5.9", "100", "150", "abc", "efg", "null", "true", "false"]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], false)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], false)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], false)
                XCTAssertEqual(models[9], false)
                XCTAssertEqual(models[10], true)
                XCTAssertEqual(models[11], false)
                XCTAssertEqual(models[12], false)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
            ["0", "1", "2", "3", "4.5", "5.9", "100", "150", "abc", "efg", "null", "true", "false"]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], false)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], false)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], false)
                XCTAssertEqual(models[9], false)
                XCTAssertEqual(models[10], false)
                XCTAssertEqual(models[11], true)
                XCTAssertEqual(models[12], false)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    // MARK: - Null -> Bool
    /// null默认为false
    func testNullToBool() {
        if true {
            let data: Data = """
            [null, null, null]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], false)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toBool(path: AbstractPath, value: NSNull) -> Bool {
                    return true
                }
            }
            let data: Data = """
                   [null, null, null]
                   """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
                XCTAssertEqual(models[0], true)
                XCTAssertEqual(models[1], true)
                XCTAssertEqual(models[2], true)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    // MARK: - Number -
    /// 默认true映射为1 false 映射为0
    func testBoolToInt() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Int] = try decoder.decode(type: [Int].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt(path: AbstractPath, value: Bool) -> Int {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false, 0, 1, 2]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Int] = try decoder.decode(type: [Int].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToInt8() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Int8] = try decoder.decode(type: [Int8].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt8(path: AbstractPath, value: Bool) -> Int8 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Int8] = try decoder.decode(type: [Int8].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToInt16() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Int16] = try decoder.decode(type: [Int16].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt16(path: AbstractPath, value: Bool) -> Int16 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Int16] = try decoder.decode(type: [Int16].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToInt32() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Int32] = try decoder.decode(type: [Int32].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt32(path: AbstractPath, value: Bool) -> Int32 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Int32] = try decoder.decode(type: [Int32].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }


    func testBoolToInt64() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Int64] = try decoder.decode(type: [Int64].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt64(path: AbstractPath, value: Bool) -> Int64 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Int64] = try decoder.decode(type: [Int64].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToUInt() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [UInt] = try decoder.decode(type: [UInt].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toUInt(path: AbstractPath, value: Bool) -> UInt {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
                [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [UInt] = try decoder.decode(type: [UInt].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToUInt8() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [UInt8] = try decoder.decode(type: [UInt8].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toUInt8(path: AbstractPath, value: Bool) -> UInt8 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [UInt8] = try decoder.decode(type: [UInt8].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToUInt16() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [UInt16] = try decoder.decode(type: [UInt16].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toUInt16(path: AbstractPath, value: Bool) -> UInt16 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [UInt16] = try decoder.decode(type: [UInt16].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToUInt32() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [UInt32] = try decoder.decode(type: [UInt32].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toUInt32(path: AbstractPath, value: Bool) -> UInt32 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [UInt32] = try decoder.decode(type: [UInt32].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToUInt64() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [UInt64] = try decoder.decode(type: [UInt64].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toUInt64(path: AbstractPath, value: Bool) -> UInt64 {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [UInt64] = try decoder.decode(type: [UInt64].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToFloat() {
        if true {
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Float] = try decoder.decode(type: [Float].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toFloat(path: AbstractPath, value: Bool) -> Float {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
            [true, false]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Float] = try decoder.decode(type: [Float].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }


    func testBoolToDouble() {
        if true {
            let data: Data = """
              [true, false]
              """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Double] = try decoder.decode(type: [Double].self, from: data) else { return }
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toDouble(path: AbstractPath, value: Bool) -> Double {
                    if value {
                        return 0
                    }
                    return 1
                }
            }
            let data: Data = """
               [true, false]
               """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [Double] = try decoder.decode(type: [Double].self, from: data) else { return }
                XCTAssertEqual(models[0], 0)
                XCTAssertEqual(models[1], 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testBoolToString() {
        if true {
            let data: Data = """
              [true, false]
              """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [String] = try decoder.decode(type: [String].self, from: data) else { return }
                XCTAssertEqual(models[0], "true")
                XCTAssertEqual(models[1], "false")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toString(path: AbstractPath, value: Bool) -> String {
                    if value {
                        return "1"
                    }
                    return "0"
                }
            }
            let data: Data = """
               [true, false]
               """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: [String] = try decoder.decode(type: [String].self, from: data) else { return }
                XCTAssertEqual(models[0], "1")
                XCTAssertEqual(models[1], "0")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testInt() {
        struct Example: Codable {
            var name: Int
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        {"name": null}
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssertEqual(models?[0].name, 1)
            XCTAssertEqual(models?[1].name, 0)
            XCTAssertEqual(models?[2].name, 1)
            XCTAssertEqual(models?[3].name, 0)
            XCTAssertEqual(models?[4].name, 1)
            XCTAssertEqual(models?[5].name, 0)
            XCTAssertEqual(models?[6].name, 2)
            XCTAssertEqual(models?[7].name, 1)
            XCTAssertEqual(models?[8].name, 0)
            XCTAssertEqual(models?[9].name, -1)
            XCTAssertEqual(models?[10].name, -2)
            XCTAssertEqual(models?[11].name, 0)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testInt8() {
        struct Example: Codable {
            var name: Int8
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssertEqual(models?[0].name, 1)
            XCTAssertEqual(models?[1].name, 0)
            XCTAssertEqual(models?[2].name, 1)
            XCTAssertEqual(models?[3].name, 0)
            XCTAssertEqual(models?[4].name, 0)
            XCTAssertEqual(models?[5].name, 0)
            XCTAssertEqual(models?[6].name, 2)
            XCTAssertEqual(models?[7].name, 1)
            XCTAssertEqual(models?[8].name, 0)
            XCTAssertEqual(models?[9].name, -1)
            XCTAssertEqual(models?[10].name, -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testInt16() {
        struct Example: Codable {
            var name: Int16
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            XCTAssert(models?[9].name == -1)
            XCTAssert(models?[10].name == -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testInt32() {
        struct Example: Codable {
            var name: Int32
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            XCTAssert(models?[9].name == -1)
            XCTAssert(models?[10].name == -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testInt64() {
        struct Example: Codable {
            var name: Int64
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            XCTAssert(models?[9].name == -1)
            XCTAssert(models?[10].name == -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testUInt() {
        struct Example: Codable {
            var name: UInt
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0}
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            //            XCTAssert(models?[9].name == UInt("-1"))
            //            XCTAssert(models?[10].name == UInt("-2"))
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testUInt8() {
        struct Example: Codable {
            var name: UInt8
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            //            XCTAssert(models?[9].name == UInt8("-1"))
            //            XCTAssert(models?[10].name == UInt8("-2"))
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testUInt16() {
        struct Example: Codable {
            var name: UInt16
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            //            XCTAssert(models?[9].name == UInt8("-1"))
            //            XCTAssert(models?[10].name == UInt8("-2"))
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testUInt32() {
        struct Example: Codable {
            var name: UInt32
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            //            XCTAssert(models?[9].name == UInt8("-1"))
            //            XCTAssert(models?[10].name == UInt8("-2"))
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testUInt64() {
        struct Example: Codable {
            var name: UInt64
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0}
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testFloat() {
        struct Example: Codable {
            var name: Float
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            XCTAssert(models?[9].name == -1)
            XCTAssert(models?[10].name == -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testDouble() {
        struct Example: Codable {
            var name: Double
        }
        let data: Data = """
        [
        {"name": true},
        {"name": false},
        {"name": "true"},
        {"name": "false"},
        {"name": "yes"},
        {"name": "no"},
        {"name": 2},
        {"name": 1},
        {"name": 0},
        {"name": -1},
        {"name": -2},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
            XCTAssert(models?[0].name == 1)
            XCTAssert(models?[1].name == 0)
            XCTAssert(models?[2].name == 1)
            XCTAssert(models?[3].name == 0)
            XCTAssert(models?[4].name == 0)
            XCTAssert(models?[5].name == 0)
            XCTAssert(models?[6].name == 2)
            XCTAssert(models?[7].name == 1)
            XCTAssert(models?[8].name == 0)
            XCTAssert(models?[9].name == -1)
            XCTAssert(models?[10].name == -2)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testString() {
        struct Example: Codable {
            var name: String
        }
        let data: Data = """
        [
        {"name": 1},
        {"name": 0},
        ]
        """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        do {
            guard let models: [Example] = try decoder.decode(type: [Example].self, from: data) else { return }
            XCTAssertEqual(models[0].name, "1")
            XCTAssertEqual(models[1].name, "0")
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testDictionary() {
        if true {
            struct Adapter: Codable, ValueControllable {
                func emptyValue(path: AbstractPath, source: Any) -> Initalizable {
                    return Example(path: path, source: source)
                }
            }
            struct Example: Codable, Initalizable {
                init(path: AbstractPath, source: Any) {
                    self.name = "unknow"
                }

                var name: String
            }
            let data: Data = """
                {}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.keyedEmptyValueStrategy = .useCustom(Adapter())
            do {
                let model: Example? = try decoder.decode(type: Example.self, from: data)
                XCTAssertEqual(model?.name, "unknow")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
                {
                    "key": [
                        {"info": "b"}
                    ]
                }
            """.data(using: String.Encoding.utf8) ?? Data()

            class Root: Codable {
                var key: [Key]?
            }

            class Key: Codable {
                var info: String?
            }
            let decoder = NIOJSONDecoder()
            do {
                let model: Root? = try decoder.decode(type: Root.self, from: data)
                XCTAssert(model?.key != nil)
                XCTAssert(model?.key?[0].info == "b")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
            {"key": {"key": {"key": "key"}}}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()

            class Root: Codable {
                var key: Key0?
                enum CodingKeys: String, CodingKey {
                    case key = "key"
                }
            }
            class Key0: Codable {
                var key: Key1?
            }
            class Key1: Codable {
                var key: String?
            }
            do {
                let model: Root? = try decoder.decode(type: Root.self, from: data)
                XCTAssert(model?.key?.key?.key == "key")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testArray() {
        if true {
            struct Root: Codable {
                let info: [Bool]?
            }
            let data: Data = """
                {"info": [] }
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                let models = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(models?.info?.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: ValueControllable {
                func nullValue(path: AbstractPath, source: Any) -> Initalizable {
                    if path.codingPath == AbstractPath().dictionary(index: "info").codingPath {
                        return Array<Bool>(path: path, source: source)
                    }
                    return path as! Initalizable
                }
            }

            struct Root: Codable {
                let info: [Bool]?
            }
            let data: Data = """
                {"info": null }
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            decoder.keyedNullValueStrategy = .useCustom(Adapter())
            do {
                let models = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(models?.info, nil)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Example: Codable {
                var name: String
            }
            let data: Data = """
            [{"name": "2ddf"}, {"name": null}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Example] = try decoder.decode(type: [Example].self, from: data) else { return }
                XCTAssert(models.count == 2)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Example: Codable {
                var name: Int64
            }
            let data: Data = """
            [
            ]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                let models: [Example]? = try decoder.decode(type: [Example].self, from: data)
                XCTAssertEqual(models?.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
            [
                true, false
            ]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: [Bool] = try decoder.decode(type: [Bool].self, from: data) else {
                    XCTAssert(false)
                    return
                }
                XCTAssert(models.count == 2)
                XCTAssert(models[0] == true)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
            {
                "a": [{"b": "c"}]
            }
            """.data(using: String.Encoding.utf8) ?? Data()

            class Root: Codable {
                var a: [A]?
            }
            class A: Codable {
                var b: String?
            }

            let decoder = NIOJSONDecoder()
            do {
                guard let models: Root = try decoder.decode(type: Root.self, from: data) else {
                    XCTAssert(false)
                    return
                }
                XCTAssert(models.a?.count == 1)
                XCTAssert(models.a?[0].b == "c")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            let data: Data = """
                [[
                {"name": true}
                ]]
                """.data(using: String.Encoding.utf8) ?? Data()

            class A: Codable {
                var name: String?
            }

            struct Adapter: KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    print(sourcePath.codingPath)
                    return sourcePath
                }
            }

            let decoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useCustom(Adapter())
            do {
                guard let models: [[A]] = try decoder.decode(type: [[A]].self, from: data) else { return }
                XCTAssertEqual(models.count, 1)
                XCTAssertEqual(models[0][0].name, "true")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testMapping() {
        if true {
            struct A: Codable {
                var a: [B?]
            }

            struct B: Codable {
                var gender: Gender?
            }

            enum Gender: Int, Codable {
                case male = 0
                case female = 1
                case unknow = 2
            }

            let data: Data = """
            {
             "a": [{"gender": 0}, {"gender": 1}, {"gender": 2}]
            }
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = NIOJSONDecoder()
            do {
                guard let models: A = try decoder.decode(type: A.self, from: data) else { return }
                XCTAssert((models.a[0]?.gender ?? Gender.unknow) == Gender.male)
                XCTAssert((models.a[1]?.gender ?? Gender.unknow) == Gender.female)
                XCTAssert((models.a[2]?.gender ?? Gender.unknow) == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible {
                func toInt(path: AbstractPath, value: Int) -> Int {
                    if path.codingPath == AbstractPath().dictionary(index: "gender").codingPath && value > 2 {
                        return 0
                    }
                    return value
                }
            }

            struct Human: Codable {
                var gender: Gender?
            }
            enum Gender: Int, Codable {
                case unknow = 0
                case male = 1
                case female = 2

                enum CodingKeys: CodingKey {
                    case male
                    case female
                    case unknow
                }
            }

            let data: Data = """
             {"gender": 4}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: Human = try decoder.decode(type: Human.self, from: data) else { return }
                XCTAssert(models.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Human: Codable {
                var gender: Gender?
            }

            enum Gender: Int, Codable, TypeConvertible {
                case unknow = 0
                case male = 1
                case female = 2

                enum CodingKeys: CodingKey {
                    case male
                    case female
                    case unknow
                }

                func toInt(path: AbstractPath, value: Double) -> Int {
                    print(value)
                    return 0
                }
            }

            let data: Data = """
                    {"gender": 3.5}
                   """.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Gender.male)
            do {
                guard let models: Human = try decoder.decode(type: Human.self, from: data) else { return }
                XCTAssert(models.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Human: Codable {
                var gender: Gender?
                var name: Int
                var age: Int
            }

            enum Gender: Int, Codable {
                case unknow = 0
                case male = 1
                case female = 2

                enum CodingKeys: CodingKey {
                    case unknow
                    case male
                    case female
                }
            }

            let data: Data = """
                    {"gender": 3,
                    "name": 3,
                    "age": 4
                    }
            """.data(using: String.Encoding.utf8) ?? Data()

            struct Adapter: TypeConvertible {
                func toInt(path: AbstractPath, value: Int) -> Int {
                    if path.codingPath == AbstractPath().dictionary(index: "gender").codingPath && value > 2 {
                        return 0
                    }
                    return value
                }
            }

            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.convertTypeStrategy = .useCustom(Adapter())
            do {
                guard let models: Human = try decoder.decode(type: Human.self, from: data) else { return }
                XCTAssert(models.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

    }

    /// 继承问题
    func testInherit()  {
        class Wine: Codable {
            var abv: Float?
        }
        class Beer: Wine {
            var name: String?
            var brewery: String?
            enum CodingKeys: String, CodingKey {
                case name
                case brewery
            }

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.name = try container.decode(String.self, forKey: .name)
                self.brewery = try container.decode(String.self, forKey: .brewery)
                try super.init(from: decoder)
            }
        }

        let jsonDic = ["name": "beer", "brewery": "100", "abv": 10.0] as [String : Any]

        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        let decode = NIOJSONDecoder()
        do {
            let beer = try decode.decode(type: Beer.self, from: jsonData)
            print("解析成功:\(beer.debugDescription)")
        } catch  {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testFlattening() {
        enum Level: String, Codable {
            case large
            case medium
            case small
        }

        struct Location: Codable {
            let latitude: Double
            let longitude: Double
        }

        // CustomDebugStringConvertible只是为了更好打印
        class City: Codable, CustomDebugStringConvertible {
            let name: String
            let pop: UInt
            let level: Level
            let location: Location

            /// 计算属性不参与codable过程
            var debugDescription: String {
                return """
                {
                "name": \(name),
                "pop": \(pop),
                "level": \(level.rawValue),
                "location": {
                "latitude": \(location.latitude),
                "longitude": \(location.longitude)
                }
                }
                """
            }
        }

        let jsonData = """
                {
                "name": "Shanghai",
                "pop": 21000000,
                "level": "large",
                "location": {
                  "latitude": 30.40,
                  "longitude": 120.51
                }
                }
                """.data(using: .utf8)!
        do {
            let city = try JSONDecoder().decode(City.self, from: jsonData)
            print("city:", city)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testNull() {
        struct Adapter: TypeConvertible {
            func toBool(path: AbstractPath, value: NSNull) -> Bool {
                if path == AbstractPath().array(index: 0) {
                    return true
                } else if path == AbstractPath().array(index: 1) {
                    return false
                }
                return false
            }
        }
        let data: Data = """
            [null, null]
          """.data(using: String.Encoding.utf8) ?? Data()
        let decoder = NIOJSONDecoder()
        decoder.convertNullStrategy = true
        decoder.convertTypeStrategy = .useCustom(Adapter())
        do {
            guard let models: [Bool?] = try decoder.decode(type: [Bool?].self, from: data) else { return }
            print(models)
            XCTAssertEqual(models[0], true)
            XCTAssertEqual(models[1], false)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testKeyNoFound() {
        if true {

            struct Adapter: KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    if sourcePath.codingPath == AbstractPath().dictionary(index: "array").codingPath {
                        return AbstractPath().dictionary(index: "key")
                    }
                    return sourcePath
                }
            }

            let data: Data = """
                {"key": "abc"}
            """.data(using: String.Encoding.utf8) ?? Data()

            class Root: Codable {
                var array: String?
            }

            let decoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useCustom(Adapter())
            do {
                guard let models: Root = try decoder.decode(type: Root.self, from: data) else { return }
                print(models)
                XCTAssert(models.array == "abc")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Human: Codable {
                var gender: Gender
                var age: Int
            }

            enum Gender: String, Codable {
                case male
                case female
            }

            struct Adapter: TypeConvertible, KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    if sourcePath.codingPath == AbstractPath().dictionary(index: "gender").codingPath {
                        return AbstractPath().dictionary(index: "gendergender")
                    } else if sourcePath.codingPath == AbstractPath().dictionary(index: "age").codingPath {
                        return AbstractPath().dictionary(index: "ageAge")
                    }
                    return sourcePath
                }
            }

            let data: Data = """
            {
                "gendergender": "male",
                "ageAge": 3
            }
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useCustom(Adapter())
            decoder.decodingSingleKeyNotFoundStrategy = .useCustom(Adapter())
            do {
                guard let models: Human = try decoder.decode(type: Human.self, from: data) else { return }
                XCTAssert(models.gender.rawValue == "male")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible, KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    if sourcePath.codingPath == AbstractPath().dictionary(index: "firstName").codingPath {
                        return AbstractPath().dictionary(index: "firstNameM")
                    } else if sourcePath.codingPath == AbstractPath().dictionary(index: "lastName").codingPath {
                        return AbstractPath().dictionary(index: "lastNameM")
                    }
                    return sourcePath
                }
            }

            struct Root: Codable {
                let lastName: String
                let firstName: String
            }
            let data: Data = """
                 {
                     "firstNameM": "John",
                     "lastNameM": "Smith"
                 }
                """.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useCustom(Adapter())
            do {
                guard let model: Root = try decoder.decode(type: Root.self, from: data) else { return }
                XCTAssertEqual(model.firstName, "John")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: TypeConvertible, KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    if sourcePath.codingPath == AbstractPath().dictionary(index: "infos").codingPath {
                        return AbstractPath().dictionary(index: "info")
                    }
                    return sourcePath
                }
            }

            struct Root: Codable {
                struct info: Codable {
                    let name: String
                }
                let infos: [info]
            }

            let data: Data = """
                 {
                     "info": [{"name": "ABC"}]
                 }
                """.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useDefaultable
            do {
                guard let model: Root = try decoder.decode(type: Root.self, from: data) else { return }
                print(model)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testValueNotFount() {
        struct Adapter: TypeConvertible {
            func toBool(path: AbstractPath, value: NSNull) -> Bool {
                return true
            }
        }
        let data: Data = #"""
            [null]
        """#.data(using: String.Encoding.utf8) ?? Data()
        let decoder: NIOJSONDecoder = NIOJSONDecoder()
        decoder.convertTypeStrategy = .useCustom(Adapter())
        do {
            guard let model: [Bool] = try decoder.decode(type: [Bool].self, from: data) else { return }
            XCTAssertEqual(model[0], true)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testComplex() {
        if true {
            struct Adapter: ValueControllable {
                func emptyValue(path: AbstractPath, source: Any) -> Initalizable {
                    return Cashvalues(path: path, source: source)
                }
            }

            class Root: Codable {
                var risks: [Risks]?
            }

            class Risks: Codable {
                var cashValues: [Cashvalues]?
            }

            class Cashvalues: Codable, Initalizable {
                required init(path: AbstractPath, source: Any) {

                }
            }

            let data: Data = #"""
                {
                    "risks": [{
                        "cashValues": [{}]
                    }]
                }
            """#.data(using: String.Encoding.utf8) ?? Data()
            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.keyedEmptyValueStrategy = .useCustom(Adapter())
            do {
                guard let model: Root = try decoder.decode(type: Root.self, from: data) else { return }
                XCTAssertEqual(model.risks?.count, 1)
                XCTAssertEqual(model.risks?[0].cashValues?.count, 1)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        if true {
            struct Adapter: KeyControllable {
                func key(sourcePath: AbstractPath) -> AbstractPath {
                    if sourcePath.codingPath == AbstractPath().dictionary(index: "address").array(index: 1).codingPath {
                        return AbstractPath().dictionary(index: "address").array(index: 1)
                    }
                    return sourcePath
                }
            }

            struct Root: Codable {
                let address: [Bool]
            }

            let data: Data = #"""
                {
                  "address": [true, false, []]
                }
            """#.data(using: String.Encoding.utf8) ?? Data()

            let decoder: NIOJSONDecoder = NIOJSONDecoder()
            decoder.keyedKeyNotFoundStrategy = .useCustom(Adapter())
            do {
                guard let model: Root = try decoder.decode(type: Root.self, from: data) else { return }
                print(model)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testSame() {
        struct Root: Codable {
            let info: Info
            let name: String
        }

        struct Info: Codable, Initalizable {
            let name: String
            init(path: AbstractPath, source: Any) {
                self.name = "unknow"
            }
        }

        struct Adapter: TypeConvertible, ValueControllable {
            func emptyValue(path: AbstractPath, source: Any) -> Initalizable {
                return Info(path: path, source: source)
            }

            func toString(path: AbstractPath, value: String) -> String {
                print(path)
                if path == AbstractPath().dictionary(index: "name") {
                    return "XXXX"
                }
                return value
            }
        }

        let data: Data = #"""
            {
                "name": "abc",
                "info": {}
            }
        """#.data(using: String.Encoding.utf8) ?? Data()
        let decoder: NIOJSONDecoder = NIOJSONDecoder()
        decoder.convertTypeStrategy = .useCustom(Adapter())
        decoder.keyedEmptyValueStrategy = .useCustom(Adapter())
        do {
            guard let model: Root = try decoder.decode(type: Root.self, from: data) else { return }
            XCTAssertEqual(model.name, "XXXX")
            XCTAssertEqual(model.info.name, "unknow")
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }

    func testPropertyWrapperIgnore() {
        let data: Data = #"""
            {
                "name": "abc",
                "info": "info",
                "data": "datat"
            }
        """#.data(using: String.Encoding.utf8) ?? Data()

        struct Information: Codable {
            @Ignore.NonoptionalCoding
            var name: String = "10JQKA"
            @Ignore.OptionalCoding
            var info: String? = nil
            @Base64.DecodingToString
            var data: String?
        }
        let decoder: NIOJSONDecoder = NIOJSONDecoder()
        guard let model = try? decoder.decode(type: Information.self, from: data) else { return }
        XCTAssertEqual(model.name, "10JQKA")
        XCTAssertEqual(model.info, nil)
        print(model.data ?? "")
    }

    func testPropertyWrapperBase64() {
        let data: Data = #"""
            {
                "name": "abc"
            }
        """#.data(using: String.Encoding.utf8) ?? Data()

        struct Information: Codable {
            @CustomKey(keys: "name", "ABC")
            var namee: String?
        }
        let decoder: NIOJSONDecoder = NIOJSONDecoder()
        let model = try? decoder.decode(type: Information.self, from: data)
        print(model?.namee)
    }
}
