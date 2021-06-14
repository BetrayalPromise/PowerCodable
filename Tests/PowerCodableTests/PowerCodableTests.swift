import XCTest
@testable import PowerCodable

final class DecodeTests: XCTestCase {
    let decoder = PowerJSONDecoder()
    
    /// 处理null, {}, []
    func testEmpty() {
        let data: Data = """
            {"a0": null, "b0":[], "c0": {}}
        """.data(using: String.Encoding.utf8) ?? Data()
        struct A: Decodable, DecodeKeyMappable {
            let a: Bool
            let b: Bool
            let c: Bool
            static func moodelToKeys() -> [String: [String]] {
                return ["a": ["a0"], "b": ["b0"], "c": ["c0"]]
            }
        }
        do {
            let model: A = try decoder.decode(type: A.self, from: data)
            XCTAssertEqual(model.a, false)
            XCTAssertEqual(model.b, false)
            XCTAssertEqual(model.c, false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testEmptyContainer() {
        if true {
            let data0: Data = """
            []
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model = try decoder.decode(type: [Bool].self, from: data0)
                XCTAssertEqual(model.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        
        if true {
            let data: Data = """
            {}
            """.data(using: String.Encoding.utf8) ?? Data()
            struct A: Codable {
                let int: Int
                let int8: Int8
                let int16: Int16
                let int32: Int32
                let int64: Int64
                let uint: UInt
                let uint8: UInt8
                let uint16: UInt16
                let uint32: UInt32
                let uint64: UInt64
                let float: Float
                let double: Double
            }
            do {
                let model = try decoder.decode(type: A.self, from: data)
                XCTAssertEqual(model.int, 0)
                XCTAssertEqual(model.int8, 0)
                XCTAssertEqual(model.int16, 0)
                XCTAssertEqual(model.int32, 0)
                XCTAssertEqual(model.int64, 0)
                XCTAssertEqual(model.uint, 0)
                XCTAssertEqual(model.uint8, 0)
                XCTAssertEqual(model.uint16, 0)
                XCTAssertEqual(model.uint32, 0)
                XCTAssertEqual(model.uint64, 0)
                XCTAssertEqual(model.float, 0)
                XCTAssertEqual(model.double, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
    
    func testBool() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}, "", "dfadfad"]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Bool] = try decoder.decode(type: [Bool].self, from: data)
            XCTAssertEqual(model[0], true)
            XCTAssertEqual(model[1], false)
            XCTAssertEqual(model[2], false)
            XCTAssertEqual(model[3], true)
            XCTAssertEqual(model[4], false)
            XCTAssertEqual(model[5], false)
            XCTAssertEqual(model[6], false)
            XCTAssertEqual(model[7], false)
            XCTAssertEqual(model[8], false)
            XCTAssertEqual(model[9], false)
            XCTAssertEqual(model[10], false)
            XCTAssertEqual(model[11], false)
            XCTAssertEqual(model[12], false)
            XCTAssertEqual(model[13], false)
            XCTAssertEqual(model[14], false)
            XCTAssertEqual(model[15], false)
            XCTAssertEqual(model[16], false)
            XCTAssertEqual(model[17], false)
            XCTAssertEqual(model[18], false)
            XCTAssertEqual(model[19], false)
            XCTAssertEqual(model[20], false)
            XCTAssertEqual(model[22], false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalBool() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Bool?] = try decoder.decode(type: [Bool?].self, from: data)
            XCTAssertEqual(model[0], true)
            XCTAssertEqual(model[1], false)
            XCTAssertEqual(model[2], false)
            XCTAssertEqual(model[3], true)
            XCTAssertEqual(model[4], false)
            XCTAssertEqual(model[5], false)
            XCTAssertEqual(model[6], false)
            XCTAssertEqual(model[7], false)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], false)
            XCTAssertEqual(model[10], false)
            XCTAssertEqual(model[11], false)
            XCTAssertEqual(model[12], false)
            XCTAssertEqual(model[13], false)
            XCTAssertEqual(model[14], false)
            XCTAssertEqual(model[15], false)
            XCTAssertEqual(model[16], false)
            XCTAssertEqual(model[17], false)
            XCTAssertEqual(model[18], false)
            XCTAssertEqual(model[19], false)
            XCTAssertEqual(model[20], false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInt() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int] = try decoder.decode(type: [Int].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalInt() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int?] = try decoder.decode(type: [Int?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInt8() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int8] = try decoder.decode(type: [Int8].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalInt8() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int8?] = try decoder.decode(type: [Int8?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInt16() {
        let data: Data = #"""
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """#.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int16] = try decoder.decode(type: [Int16].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalInt16() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int16?] = try decoder.decode(type: [Int16?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInt32() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int32] = try decoder.decode(type: [Int32].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalInt32() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int32?] = try decoder.decode(type: [Int32?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInt64() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int64] = try decoder.decode(type: [Int64].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalInt64() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Int64?] = try decoder.decode(type: [Int64?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], -6)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUInt() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt] = try decoder.decode(type: [UInt].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalUInt() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt?] = try decoder.decode(type: [UInt?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUInt8() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt8] = try decoder.decode(type: [UInt8].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalUInt8() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt8?] = try decoder.decode(type: [UInt8?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUInt16() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt16] = try decoder.decode(type: [UInt16].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalUInt16() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt16?] = try decoder.decode(type: [UInt16?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUInt32() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model: [UInt32] = try decoder.decode(type: [UInt32].self, from: data) 
                XCTAssertEqual(model[0], 1)
                XCTAssertEqual(model[1], 0)
                XCTAssertEqual(model[2], 0)
                XCTAssertEqual(model[3], 1)
                XCTAssertEqual(model[4], 2)
                XCTAssertEqual(model[5], 3)
                XCTAssertEqual(model[6], 4)
                XCTAssertEqual(model[7], 0)
                XCTAssertEqual(model[8], 0)
                XCTAssertEqual(model[9], 0)
                XCTAssertEqual(model[10], 0)
                XCTAssertEqual(model[11], 0)
                XCTAssertEqual(model[12], 0)
                XCTAssertEqual(model[13], 0)
                XCTAssertEqual(model[14], 0)
                XCTAssertEqual(model[15], 0)
                XCTAssertEqual(model[16], 0)
                XCTAssertEqual(model[17], 0)
                XCTAssertEqual(model[18], 0)
                XCTAssertEqual(model[19], 0)
                XCTAssertEqual(model[20], 0)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testOptionalUInt32() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt32?] = try decoder.decode(type: [UInt32?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUInt64() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt64] = try decoder.decode(type: [UInt64].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalUInt64() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [UInt64?] = try decoder.decode(type: [UInt64?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4)
            XCTAssertEqual(model[7], 0)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFloat() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Float] = try decoder.decode(type: [Float].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4.5)
            XCTAssertEqual(model[7], -6.7)
            XCTAssertEqual(model[8], 0)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOptionalFloat() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Float?] = try decoder.decode(type: [Float?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4.5)
            XCTAssertEqual(model[7], -6.7)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDouble() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model: [Double] = try decoder.decode(type: [Double].self, from: data) 
                XCTAssertEqual(model[0], 1)
                XCTAssertEqual(model[1], 0)
                XCTAssertEqual(model[2], 0)
                XCTAssertEqual(model[3], 1)
                XCTAssertEqual(model[4], 2)
                XCTAssertEqual(model[5], 3)
                XCTAssertEqual(model[6], 4.5)
                XCTAssertEqual(model[7], -6.7)
                XCTAssertEqual(model[8], 0)
                XCTAssertEqual(model[9], 0)
                XCTAssertEqual(model[10], 0)
                XCTAssertEqual(model[11], 0)
                XCTAssertEqual(model[12], 0)
                XCTAssertEqual(model[13], 0)
                XCTAssertEqual(model[14], 0)
                XCTAssertEqual(model[15], 0)
                XCTAssertEqual(model[16], 0)
                XCTAssertEqual(model[17], 0)
                XCTAssertEqual(model[18], 0)
                XCTAssertEqual(model[19], 0)
                XCTAssertEqual(model[20], 0)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testOptionalDouble() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [Double?] = try decoder.decode(type: [Double?].self, from: data)
            XCTAssertEqual(model[0], 1)
            XCTAssertEqual(model[1], 0)
            XCTAssertEqual(model[2], 0)
            XCTAssertEqual(model[3], 1)
            XCTAssertEqual(model[4], 2)
            XCTAssertEqual(model[5], 3)
            XCTAssertEqual(model[6], 4.5)
            XCTAssertEqual(model[7], -6.7)
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], 0)
            XCTAssertEqual(model[10], 0)
            XCTAssertEqual(model[11], 0)
            XCTAssertEqual(model[12], 0)
            XCTAssertEqual(model[13], 0)
            XCTAssertEqual(model[14], 0)
            XCTAssertEqual(model[15], 0)
            XCTAssertEqual(model[16], 0)
            XCTAssertEqual(model[17], 0)
            XCTAssertEqual(model[18], 0)
            XCTAssertEqual(model[19], 0)
            XCTAssertEqual(model[20], 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testString() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model: [String] = try decoder.decode(type: [String].self, from: data) 
                XCTAssertEqual(model[0], "true")
                XCTAssertEqual(model[1], "false")
                XCTAssertEqual(model[2], "0")
                XCTAssertEqual(model[3], "1")
                XCTAssertEqual(model[4], "2")
                XCTAssertEqual(model[5], "3")
                XCTAssertEqual(model[6], "4.5")
                XCTAssertEqual(model[7], "-6.7")
                XCTAssertEqual(model[8], "null")
                XCTAssertEqual(model[9], "[]")
                XCTAssertEqual(model[10], "[]")
                XCTAssertEqual(model[11], "[]")
                XCTAssertEqual(model[12], "[]")
                XCTAssertEqual(model[13], "[]")
                XCTAssertEqual(model[14], "[]")
                XCTAssertEqual(model[15], "[]")
                XCTAssertEqual(model[16], "[]")
                XCTAssertEqual(model[17], "[]")
                XCTAssertEqual(model[18], "[]")
                XCTAssertEqual(model[19], "[:]")
                XCTAssertEqual(model[20], "[:]")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
    
    func testOptionalString() {
        let data: Data = """
            [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            let model: [String?] = try decoder.decode(type: [String?].self, from: data)
            XCTAssertEqual(model[0], "true")
            XCTAssertEqual(model[1], "false")
            XCTAssertEqual(model[2], "0")
            XCTAssertEqual(model[3], "1")
            XCTAssertEqual(model[4], "2")
            XCTAssertEqual(model[5], "3")
            XCTAssertEqual(model[6], "4.5")
            XCTAssertEqual(model[7], "-6.7")
            XCTAssertEqual(model[8], nil)
            XCTAssertEqual(model[9], "[]")
            XCTAssertEqual(model[10], "[]")
            XCTAssertEqual(model[11], "[]")
            XCTAssertEqual(model[12], "[]")
            XCTAssertEqual(model[13], "[]")
            XCTAssertEqual(model[14], "[]")
            XCTAssertEqual(model[15], "[]")
            XCTAssertEqual(model[16], "[]")
            XCTAssertEqual(model[17], "[]")
            XCTAssertEqual(model[18], "[]")
            XCTAssertEqual(model[19], "[:]")
            XCTAssertEqual(model[20], "[:]")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArray() {
        do {
            struct Root: Codable {
                var abc: String?
                var info: [Bool]?
            }
            let data: Data = """
                {"info": [], "abc": ""}
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model.info?.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        
        let json: [Any] = [1, 3 ,5]
        do {
            let model: [Int8] = try decoder.decode(type: [Int8].self, from: json)
            print(model)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testDictionary() {
        do {
            struct Root: Codable, DecodeKeyMappable {
                static func modelFieldAbsorbFields() -> [String: [String]] {
                    return ["info": ["a", "b"], "b": ["b"]]
                }
                let info: Bool
                let b: String
            }
            let data: Data = """
                {"a": true, "b": ""}
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model.info, true)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        
        do {
            let data: Data = """
                {"key": {"key": {"key": "key"}}}
            """.data(using: String.Encoding.utf8) ?? Data()
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
    
    //    func testNest() {
    //        class Person: Codable {
    //            var name: String = ""
    //            var parent: Person?
    //        }
    //
    //        let json: [String: Any] = [
    //            "name": "Jack",
    //            "parent": ["name": "Jim"]
    //        ]
    //        do {
    //            let model: Person? = try decoder.decode(type: Person.self, from: json)
    //            print(model)
    //        } catch {
    //            XCTAssertNil(error)
    //        }
    //    }
    
    func testWrapperIgnore() {
        do {
            let data: Data = #"""
                {
                    "name": "abc",
                    "info": "info",
                    "data": "datat"
                }
            """#.data(using: String.Encoding.utf8) ?? Data()
            
            struct Information: Codable {
                @Decoding.IgnoreNonoptional()
                var name: String = "10JQKA"
                @Decoding.IgnoreOptional()
                var info: String? = nil
                var data: String? = nil
            }
            do {
                let model = try decoder.decode(type: Information.self, from: data)
                XCTAssertEqual(model.name, "10JQKA")
                XCTAssertEqual(model.info, nil)
                print(model.data ?? "")
            } catch {
                XCTFail()
            }
        }
        do {
            let data: Data = #"""
                {
                    "name0": 0,
                    "name1": 1,
                    "name2": 2,
                    "name3": 3
                }
            """#.data(using: String.Encoding.utf8) ?? Data()
            
            struct Information: Decodable {
                @Default(value: "name0")
                var name0: String
                @Default(value: "name1")
                var name1: String
                @Default(value: nil)
                var name2: Bool?
                @Default(value: true)
                var name3: Bool
            }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(Information.self, from: data)
                print(model)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testMappable() {
        do {
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
                {"a": [{"gender": 0}, {"gender": 1}, {"gender": 2}]}
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                let model: A = try decoder.decode(type: A.self, from: data)
                XCTAssert((model.a[0]?.gender ?? Gender.unknow) == Gender.male)
                XCTAssert((model.a[1]?.gender ?? Gender.unknow) == Gender.female)
                XCTAssert((model.a[2]?.gender ?? Gender.unknow) == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        
        do {
            struct Adapter: DecodeValueMappable {
                static func toInt(decoder: PowerJSONDecoder, paths: [Path], value: JSON) throws -> Int {
                    if paths.current == "[:]gender" && value.isInt$ && value.int$ == 4 {
                        return 0
                    }
                    return value.int$ ?? 0
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
            decoder.strategy.valueMappable = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            struct Adapter: DecodeValueMappable {
                static func toInt(decoder: PowerJSONDecoder, paths: [Path], value: JSON) throws -> Int {
                    if paths.current == "[:]gender" {
                        return 0
                    }
                    return value.int$ ?? 0
                }
            }
            
            struct Human: Codable {
                var gender: Gender?
            }
            
            enum Gender: Int, Codable {
                case unknow = 0
                case male = 1
                case female = 2
            }
            
            let data: Data = """
                {"gender": 3.5}
            """.data(using: String.Encoding.utf8) ?? Data()
            decoder.strategy.valueMappable = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        
        do {
            struct Adapter: DecodeValueMappable {
                static func toInt(decoder: PowerJSONDecoder, paths: [Path], value: JSON) throws -> Int {
                    if paths.current == "[:]gender" {
                        return 0
                    }
                    return value.int$ ?? 0
                }
            }
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
            decoder.strategy.valueMappable = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
    
    func testPath() {
        let data: Data = """
        {
            "gender": 3,
            "name": "3",
            "age": 4,
            "hellow": [true, false, "null"]
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        let json = data.toJSON()
        let age = json["age"]
        print(age?.path() ?? "")
        print(json?.path() ?? "")
    }
    
    func testNested0() {
        do {
            let data: Data = """
                {"a": [{"b": [{"c": [{"d": [{"c": "over"}]}]}]}]}
            """.data(using: String.Encoding.utf8) ?? Data()
            struct Root: Codable {
                struct a: Codable {
                    struct b: Codable {
                        struct c: Codable {
                            struct d: Codable {
                                let c: String
                            }
                            let d: [d]
                        }
                        let c: [c]
                    }
                    let b: [b]
                }
                let a: [a]
            }
            do {
                let model: Root? = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model?.a[0].b[0].c[0].d[0].c, "over")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
    
    func testNested1() {
        class Person: Codable {
            var name: String = ""
            var parent: Person?
        }
        
        let json: [String: Any] = [
            "name": "0",
            "parent": ["name": "1"]
        ]
        do {
            let model: Person = try self.decoder.decode(type: Person.self, from: json)
            XCTAssertEqual(model.name, "0")
            XCTAssertEqual(model.parent?.name, "1")
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
    
    func testParadigm() {
        struct NetResponse<Element: Codable>: Codable {
            var data: Element? = nil
            var msg: String = ""
            private(set) var code: Int = 0
        }
        
        struct User: Codable {
            var id: String = ""
            var nickName: String = ""
        }
        
        struct Goods: Codable {
            private(set) var price: CGFloat = 0.0
            var name: String = ""
        }
        
        do {
            let json = """
            {
                "data": {"nickName": "KaKa", "id": 213234234},
                "msg": "Success",
                "code" : 200
            }
            """
            let model: NetResponse<User> = try self.decoder.decode(type: NetResponse<User>.self, from: json)
            XCTAssert(model.msg == "Success")
            XCTAssert(model.code == 200)
            XCTAssert(model.data?.nickName == "KaKa")
            XCTAssert(model.data?.id == "213234234")
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
        
        do {
            let json = """
            {
                "data": [
                    {"price": "6199", "name": "iPhone XR"},
                    {"price": "8199", "name": "iPhone XS"},
                    {"price": "9099", "name": "iPhone Max"}
                ],
                "msg": "Success",
                "code" : 200
            }
            """
            let model: NetResponse<[Goods]> = try self.decoder.decode(type: NetResponse<[Goods]>.self, from: json)
            XCTAssert(model.msg == "Success")
            XCTAssert(model.code == 200)
            XCTAssert(model.data?.count == 3)
            XCTAssert(model.data?[0].price == 6199)
            XCTAssert(model.data?[0].name == "iPhone XR")
            XCTAssert(model.data?[1].price == 8199)
            XCTAssert(model.data?[1].name == "iPhone XS")
            XCTAssert(model.data?[2].price == 9099)
            XCTAssert(model.data?[2].name == "iPhone Max")
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
    
    func testURL() {
        let data: Data = """
        {
            "baidubaibaidu": "http://192.168.0.103"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        struct Root :Codable, DecodeKeyMappable {
            let baidu: URL
            
            static func modelFieldAbsorbFields() -> [String: [String]] {
                return ["baidu": ["baidubaibaidu", "baidu"]]
            }
        }
        do {
            let model: Root = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(model.baidu.absoluteString, "http://192.168.0.103")
            print(model.baidu)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
    
    func testType() {
        /// Data -> Decodable
        do {
            let data: Data = """
                [false, true]
            """.data(using: String.Encoding.utf8) ?? Data()
            let json = try decoder.decode(type: [Bool].self, from: data)
            print(json)
            XCTAssertEqual(json[0], false)
            XCTAssertEqual(json[1], true)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        /// String -> Decodable
        do {
            let string: String = """
                [false, true]
            """
            let json = try decoder.decode(type: [Bool].self, from: string)
            print(json)
            XCTAssertEqual(json[0], false)
            XCTAssertEqual(json[1], true)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        /// JSON -> Decodable
        do {
            let root = JSON(array: [.bool(false), .bool(true)])
            let json = try decoder.decode(type: [Bool].self, from: root)
            print(json)
            XCTAssertEqual(json[0], false)
            XCTAssertEqual(json[1], true)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        /// JSON -> Decodable
        do {
            let root = JSON(array: [.bool(false), .bool(true)])
            let json = try decoder.decode(type: [Bool].self, from: root)
            print(json)
            XCTAssertEqual(json[0], false)
            XCTAssertEqual(json[1], true)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        /// JSONWrapper -> Decodable
        do {
            let root = JSONWrapper(wrapper: [true, false])
            let json = try decoder.decode(type: [Bool].self, from: root)
            XCTAssertEqual(json[0], true)
            XCTAssertEqual(json[1], false)
            print(json)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNumber() {
        struct Numbers: Codable {
            let a: Float
            let b: Double
            let c: Float
            let d: Double
            let e: Float
            let f: Double
            let g: Float
            let h: Double
            
            let i: Float
            let j: Float
            let k: Float
            
            let l: Double
            let m: Double
            let n: Double
        }
        let data: Data = """
        {
          "a": "nan",
          "b": "Nan",
          "c": "nAn",
          "d": "naN",
          "e": "NAn",
          "f": "NaN",
          "g": "nAN",
          "h": "NAN",
          "i": "-infinity",
          "j": "infinity",
          "k": "+infinity",
          "l": "-infinity",
          "m": "infinity",
          "n": "+infInitY"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        
        do {
            let json: Numbers = try decoder.decode(type: Numbers.self, from: data)
            XCTAssertEqual(json.a.isNaN, true)
            XCTAssertEqual(json.b.isNaN, true)
            XCTAssertEqual(json.c.isNaN, true)
            XCTAssertEqual(json.d.isNaN, true)
            XCTAssertEqual(json.e.isNaN, true)
            XCTAssertEqual(json.f.isNaN, true)
            XCTAssertEqual(json.g.isNaN, true)
            XCTAssertEqual(json.h.isNaN, true)
            XCTAssertEqual(json.i, -Float.infinity)
            XCTAssertEqual(json.j, Float.infinity)
            XCTAssertEqual(json.k, Float.infinity)
            XCTAssertEqual(json.l, -Double.infinity)
            XCTAssertEqual(json.m, Double.infinity)
            XCTAssertEqual(json.n, Double.infinity)
            
            XCTAssertTrue(json.l.isInfinite)
            XCTAssertTrue(json.m.isInfinite)
            XCTAssertTrue(json.n.isInfinite)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNull() {
        let data: Data = """
        {
        
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            struct Root: Codable {
                let hello : String
            }
            let json = try decoder.decode(type: Root.self, from: data)
            print(json)
            XCTAssertEqual(json.hello, "[:]")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDate() {
        //        1603782840000
        let data: Data = """
        {
            "date": "1603782840123"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        do {
            struct Root: Codable {
                let date : Date
            }
            self.decoder.strategy.dateValueMappable = .custom({ (decoder, paths, value) -> Date in
                return Date()
            })
            let model: Root = try decoder.decode(type: Root.self, from: data)
            print(model)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        print(now.formatted(format:  "%y|%Y|%m|%d|%I|%H|%M|%S|%w|%z|%Z") ?? "")
        
        let string = "1603539281"
        print(string.toDate())
    }
    
    func testFormatKeyMappable() {
        let data: Data = """
        {
            "string_data": "string"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        self.decoder.strategy.keyMappable = .useSnakeKeys(StringCaseFormat.SnakeCase.default)
        defer {
            self.decoder.strategy.keyMappable = .useDefaultKeys
        }
        do {
            struct Root: Codable {
                let stringData: String
            }
            let json = try decoder.decode(type: Root.self, from: data)
            print(json)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testKeyMappable() {
        do {
            let data: Data = """
            {
                "a0": "a",
                "b0": "b",
                "c0": {
                    "c0": "c",
                    "d0": "d",
                    "e0": {
                        "e0": "e",
                        "f0": "f",
                        "g0": "g"
                    }
                }
            }
            """.data(using: String.Encoding.utf8) ?? Data()
            do {
                struct Root : Codable, DecodeKeyMappable {
                    let a : String?
                    let b : String?
                    let c : C?
                    
                    static func modelFieldAbsorbFields() -> [String: [String]] {
                        return ["a": ["a0"], "b": ["b0"], "c":["c0"]]
                    }
                }
                struct C : Codable, DecodeKeyMappable {
                    let c : String?
                    let d : String?
                    let e : E?
                    
                    static func modelFieldAbsorbFields() -> [String: [String]] {
                        return ["c": ["c0"], "d": ["d0"], "e": ["e0"]]
                    }
                }
                struct E : Codable, DecodeKeyMappable {
                    let f : String?
                    let g : String?
                    static func modelFieldAbsorbFields() -> [String: [String]] {
                        return ["e":["e0"], "f": ["f0"], "g": ["g0"]]
                    }
                }
                let model = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model.a, "a")
                XCTAssertEqual(model.b, "b")
                XCTAssertEqual(model.c?.c, "c")
                XCTAssertEqual(model.c?.d, "d")
                XCTAssertEqual(model.c?.e?.f, "f")
                XCTAssertEqual(model.c?.e?.g, "g")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testData() {
        let data: Data = """
        {
            "data0": "0xff055008",
            "data1": true,
            "data2": null,
            "data3": [true]
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        
        do {
            struct Root: Codable {
                let data0: Data
                let data1: Data
                let data2: Data
                let data3: Data
            }
            let json = try decoder.decode(type: Root.self, from: data)
            XCTAssertNotEqual(json.data0.count, 0)
            XCTAssertEqual(json.data1.count, 0)
            XCTAssertEqual(json.data2.count, 0)
            XCTAssertEqual(json.data3.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testJSON() {
        let jsondoc = #"""
        {
          "imAString": "aString",
          "imAnInt": 1,
          "imADouble": 0.5,
          "imABool": true,
          "imAnArray": [1,2,"3",false],
          "imAnArrayOfArrays": [[[[[[[true]]]]]]],
          "imAnObject": {"imAnotherString": "anotherString"},
          "imAnObjectInAnObject": {"anObj": {"anInt": 1}},
          "imAnArrayOfObjects": [{"anObj": {"anInt": 1}}, {"aBool": true}]
        }
        """#
        do {
            let root: JSON = try PowerJSONDecoder().decode(type: JSON.self, from: jsondoc.data(using: .utf8)!)
            XCTAssertEqual(root["imAString"], JSON(stringLiteral: "aString"))
            XCTAssertEqual(root["imAnInt"], JSON(integerLiteral: 1))
            XCTAssertEqual(root["imADouble"], JSON(floatLiteral: 0.5))
            XCTAssertEqual(root["imABool"], JSON(booleanLiteral: true))
            XCTAssertEqual(root["imAnArray"], JSON(arrayLiteral: 1, 2, "3", false))
            XCTAssertEqual(root["imAnObject"], JSON(dictionaryLiteral: ("imAnotherString", "anotherString")))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testStartPath() {
        let data: Data = """
        {
            "data": [0, 1, 3]
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        
        do {
            let decoder = PowerJSONDecoder()
            decoder.strategy.startPaths = ["data".path]
            let root: [Int] = try decoder.decode(type: [Int].self, from: data)
            XCTAssertEqual(root[0], 0)
            XCTAssertEqual(root[1], 1)
            XCTAssertEqual(root[2], 3)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

final class EncodeTests: XCTestCase {
    let encoder = PowerJSONEncoder()
    func testEncode()  {
        struct A : Encodable, EncodeKeyMappable {
            var bool: Bool = true
            var int: Int = 0
            var int8: Int8 = 1
            var int16: Int16 = 2
            var int32: Int32 = 3
            var int64: Int64 = 4
            var uint: UInt = 0
            var uint8: UInt8 = 1
            var uint16: UInt16 = 2
            var uint32: UInt32 = 3
            var uint64: UInt64 = 4
            var float: Float = 100.0
            var double: Double = 100.0
            var string: String = "ABCD"
            static func encodeKeys() -> [String: String] {
                return ["string": "hello"]
            }
        }
        do {
            let json: JSON = try encoder.encode(value: A(), to: JSON.self)
            XCTAssertEqual(json["bool"], true)
            XCTAssertEqual(json["int"], 0)
            XCTAssertEqual(json["int8"], 1)
            XCTAssertEqual(json["int16"], 2)
            XCTAssertEqual(json["int32"], 3)
            XCTAssertEqual(json["int64"], 4)
            XCTAssertEqual(json["uint"], 0)
            XCTAssertEqual(json["uint8"], 1)
            XCTAssertEqual(json["uint16"], 2)
            XCTAssertEqual(json["uint32"], 3)
            XCTAssertEqual(json["uint64"], 4)
            XCTAssertEqual(json["float"], 100.0)
            XCTAssertEqual(json["double"], 100.0)
            XCTAssertEqual(json["hello"], "ABCD")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testEncodeHashMap() {
        struct Root: Encodable {
            var a: A = A()
            var b: A = A()
        }
        struct A: Encodable {
            var b: B = B()
        }
        struct B: Encodable {
            var c: C = C()
        }
        struct C: Encodable {
            var string = "string"
        }
        do {
            let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
            XCTAssertNotEqual(json["a"]["b"]["c"], "string")
            XCTAssertNotEqual(json["b"]["b"]["c"], "string")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArray0() {
        do {
            let json: JSON = try encoder.encode(value: [true, false], to: JSON.self)
            XCTAssertEqual(json[0], true)
            XCTAssertEqual(json[1], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArray1() {
        do {
            let json: JSON = try encoder.encode(value: [[true, true], [false]], to: JSON.self)
            XCTAssertEqual(json[0][0], true)
            XCTAssertEqual(json[0][1], true)
            XCTAssertEqual(json[1][0], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArray2() {
        struct Root: Encodable {
            var `as`: [[A]] = [[A(), A()]]
        }
        struct A: Encodable {
            var bool = false
        }
        do {
            let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
            XCTAssertEqual(json["as"][0][0]["bool"], false)
            XCTAssertEqual(json["as"][0][1]["bool"], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testArray() {
        struct Root: Encodable {
            var `as`: [A] = []
            var bs: [B] = [B()]
            var cs: [C] = [C(), C()]
        }
        struct A: Encodable {
            var bool = false
        }
        struct B: Encodable {
            var int: Int = 0
        }
        struct C: Encodable {
            var string = "string"
        }
        let root = Root()
        do {
            let json: JSON = try encoder.encode(value: root, to: JSON.self)
            XCTAssertEqual(json["as"], [])
            XCTAssertEqual(json["bs"][0]["int"], 0)
            XCTAssertEqual(json["cs"][0]["string"], "string")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testURL() {
        do {
            struct Root: Codable, EncodeKeyMappable {
                var baidu: URL = try! URL.buildURL(string: "http://www.baidu.com")
                static func encodeKeys() -> [String: String] {
                    return ["baidu": "google"]
                }
            }
            do {
                let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
                XCTAssertEqual(json["google"], "http://www.baidu.com")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            do {
                let json: JSON = try encoder.encode(value: [URL.buildURL(string: "http://www.baidu.com"), URL.buildURL(string: "http://www.baidu.com")], to: JSON.self)
                XCTAssertEqual(json[0], "http://www.baidu.com")
                XCTAssertEqual(json[1], "http://www.baidu.com")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
    
    
    func testNull() {
        do {
            struct Root: Codable {
                var baidu: Bool? = nil
            }
            do {
                let model = try encoder.encode(value: Root(), to: JSON.self)
                XCTAssertEqual(model["baidu"], JSON.null)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            do {
                let root: [Bool?]? = [true, nil]
                let model = try encoder.encode(value: root, to: String.self)
                print(model)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
    
    func testPath() {
        struct Root: Encodable {
            var `as`: [A] = []
            var bs: [B] = [B()]
            var cs: [C] = [C(), C()]
        }
        struct A: Encodable {
            var bool = false
        }
        struct B: Encodable {
            var int: Int = 0
        }
        struct C: Encodable {
            var string = "string"
        }
        do {
            let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
            print(json.path() ?? "")
            print(json["as"]?.path() ?? "")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testKey() {
        struct A: Encodable {
            var boolBool = false
        }
        
        self.encoder.strategy.keyMappable = .useSnakeKeys(.default)
        defer {
            self.encoder.strategy.keyMappable = .useDefaultKeys
        }
        do {
            let json: JSON = try encoder.encode(value: A(), to: JSON.self)
            XCTAssertNil(json["boolBool"])
            XCTAssertNotNil(json["bool_bool"])
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testValue() {
        struct A: Encodable, EncodeKeyMappable {
            var boolBool = false
            
            static func encodeKeys() -> [String : String] {
                return ["boolBool": "a"]
            }
            
            static func modelEncodingValues(paths: [Path], value: JSON) -> JSON {
                if paths.current == "[:]a" {
                    return JSON.init(nilLiteral: ())
                }
                return value
            }
        }
        
        self.encoder.strategy.keyMappable = .useSnakeKeys(.default)
        defer {
            self.encoder.strategy.keyMappable = .useDefaultKeys
        }
        do {
            let json: JSON = try encoder.encode(value: A(), to: JSON.self)
            let string: String = try encoder.encode(value: A(), to: String.self)
            print(string)
            XCTAssertNil(json["boolBool"])
            XCTAssertNotNil(json["a"])
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNumber() {
        struct A: Encodable {
            let a = Float.nan
            let b = -Float.infinity
            let c = Float.infinity
        }
        do {
            let json = try encoder.encode(value: A(), to: String.self)
            print(json)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testData() {
        do {
            struct A: Encodable {
                let a: Data = Data()
            }
            do {
                let json = try encoder.encode(value: A(), to: JSON.self)
                /// Data本质上就是二进制的数组
                XCTAssertEqual(json["a"], "")
            } catch  {
                XCTFail(error.localizedDescription)
            }
        }
        do {
            struct A: Encodable {
                let a: Data = Data(hexString: "0x234223423")
            }
            do {
                encoder.strategy.dataValueMappable = .base64
                let json = try encoder.encode(value: A(), to: JSON.self)
                /// Data本质上就是二进制的数组
                XCTAssertNotEqual(json["a"].array$?.count, 0)
            } catch  {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testDate() {
        struct A: Encodable {
            let a: Date = Date()
        }
        do {
            self.encoder.strategy.dateValueMappable = .secondsSince1970(PowerJSONEncoder.TimestampExpressionForm.number)
            let json = try encoder.encode(value: A(), to: String.self)
            print(json)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testJSON() {
        let json0 = JSON(object: ["A" : "B"])
        do {
            let data = try PowerJSONEncoder().encode(value: json0, to: String.self)
            print(data)
            let json1 = try PowerJSONDecoder().decode(type: JSON.self, from: data)
            print(json1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWrapperIgnore() {
        struct Information: Codable {
            var name: String = "10JQKA"
            var info: String? = nil
            var data: String? = nil
        }
        do {
            let model = try self.encoder.encode(value: Information(), to: JSON.self)
            print(model)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
