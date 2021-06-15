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
            static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
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
                XCTFail(error.localizedDescription)
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
                XCTFail(error.localizedDescription)
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
    
    func testInfinityAndNonentity() {
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
                XCTFail(error.localizedDescription)
            }
        }
        
        let json: [Any] = [1, 3 ,5]
        do {
            let model: [Int8] = try decoder.decode(type: [Int8].self, from: json)
            print(model)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDictionary() {
        do {
            struct Root: Codable, DecodeKeyMappable {
                static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
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
                XCTFail(error.localizedDescription)
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
                XCTFail(error.localizedDescription)
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
    //            XCTFail(error)
    //        }
    //    }
    
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
                XCTFail(error.localizedDescription)
            }
        }
    }
    
//    func testNested1() {
//        class Person: Codable {
//            var name: String = ""
//            var parent: Person?
//        }
//
//        let json: [String: Any] = [
//            "name": "0",
//            "parent": ["name": "1"]
//        ]
//        do {
//            let model: Person = try self.decoder.decode(type: Person.self, from: json)
//            XCTAssertEqual(model.name, "0")
//            XCTAssertEqual(model.parent?.name, "1")
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
    
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
            XCTFail(error.localizedDescription)
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
            XCTFail(error.localizedDescription)
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
            
            static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                return ["baidu": ["baidubaibaidu", "baidu"]]
            }
        }
        do {
            let model: Root = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(model.baidu.absoluteString, "http://192.168.0.103")
            print(model.baidu)
        } catch {
            XCTFail(error.localizedDescription)
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
            self.decoder.strategy.dateValueStrategy = .custom({ (decoder, paths, value) -> Date in
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
    
//    func testKeyDelegateMappable() {
//        // 全部字段不符合模型定义
//        do {
//            struct Adapter: DecodeKeyMappable {
//                static func modelDecodeKeys() -> [String : [String]] {
//                    
//                }
//            }
//            
//            let data: Data = """
//            {
//                "a0": "a",
//                "b0": "b",
//                "c0": {
//                    "c0": "c",
//                    "d0": "d",
//                    "e0": {
//                        "e0": "e",
//                        "f0": "f",
//                        "g0": "g"
//                    }
//                }
//            }
//            """.data(using: String.Encoding.utf8) ?? Data()
//            do {
//                struct Root : Codable, DecodeKeyMappable {
//                    let a : String?
//                    let b : String?
//                    let c : C?
//                    
//                    static func modelDecodeKeys() -> [String: [String]] {
//                        return ["a": ["a0"], "b": ["b0"], "c":["c0"]]
//                    }
//                }
//                struct C : Codable, DecodeKeyMappable {
//                    let c : String?
//                    let d : String?
//                    let e : E?
//                    
//                    static func modelDecodeKeys() -> [String: [String]] {
//                        return ["c": ["c0"], "d": ["d0"], "e": ["e0"]]
//                    }
//                }
//                struct E : Codable, DecodeKeyMappable {
//                    let f : String?
//                    let g : String?
//                    static func modelDecodeKeys() -> [String: [String]] {
//                        return ["e":["e0"], "f": ["f0"], "g": ["g0"]]
//                    }
//                }
//                let model = try decoder.decode(type: Root.self, from: data)
//                XCTAssertEqual(model.a, "a")
//                XCTAssertEqual(model.b, "b")
//                XCTAssertEqual(model.c?.c, "c")
//                XCTAssertEqual(model.c?.d, "d")
//                XCTAssertEqual(model.c?.e?.f, "f")
//                XCTAssertEqual(model.c?.e?.g, "g")
//            } catch {
//                XCTFail(error.localizedDescription)
//            }
//        }
//    }
    
    func testKeyFormatMappable() {
        let data: Data = """
        {
            "string_data": "string"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        self.decoder.strategy.keyFormatStrategy = .useSnakeKeys(StringCaseFormat.SnakeCase.default)
        defer {
            self.decoder.strategy.keyFormatStrategy = .useDefaultKeys
        }
        do {
            struct Root: Codable {
                let stringData: String
            }
            let json = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(json.stringData, "string")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testKeyDelegateMappable() {

    }
    
    func testKeyCustomMappable() {
        // 全部字段不符合模型定义
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
                    
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                        return ["a": ["a0"], "b": ["b0"], "c":["c0"]]
                    }
                }
                struct C : Codable, DecodeKeyMappable {
                    let c : String?
                    let d : String?
                    let e : E?
                    
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                        return ["c": ["c0"], "d": ["d0"], "e": ["e0"]]
                    }
                }
                struct E : Codable, DecodeKeyMappable {
                    let f : String?
                    let g : String?
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
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
        
        // 部分字段不符合模型定义
        do {
            let data: Data = """
            {
                "a0": "a",
                "b": "b",
                "c0": {
                    "c0": "c",
                    "d": "d",
                    "e0": {
                        "e0": "e",
                        "f": "f",
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
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                        return ["a": ["a0"], "b": ["b0"], "c":["c0"]]
                    }
                }
                struct C : Codable, DecodeKeyMappable {
                    let c : String?
                    let d : String?
                    let e : E?
                    
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                        return ["c": ["c0"], "d": ["d0"], "e": ["e0"]]
                    }
                }
                struct E : Codable, DecodeKeyMappable {
                    let f : String?
                    let g : String?
                    static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
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
        
        do {
            let data: Data = """
                {
                    "a0": {"a0": "a", "b": "b"},
                    "b0": "b"
                }
                """.data(using: String.Encoding.utf8) ?? Data()
            struct Root: Codable, DecodeKeyMappable {
                let a: A
                let b: String
                static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                    return ["a": ["a", "a0"], "b": ["b", "b0"]]
                }
            }
            struct A: Codable, DecodeKeyMappable {
                let b: String
                let a: String
                static func modelDecodeKeys(decoder: PowerJSONDecoder, paths: [Path]) -> [String: [String]] {
                    return ["a": ["a", "a0"]]
                }
            }
            let model = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(model.a.a, "a")
            XCTAssertEqual(model.a.b, "b")
            XCTAssertEqual(model.b, "b")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testValueDelegateMappable() {
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
                XCTFail(error.localizedDescription)
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
            decoder.strategy.valueStrategy = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTFail(error.localizedDescription)
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
            decoder.strategy.valueStrategy = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTFail(error.localizedDescription)
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
            decoder.strategy.valueStrategy = .useCustomValues(delegete: Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testValueCustomMappable() {
        do {
            let data: Data = """
            {
                "hello": "hello",
                "world": "world"
            }
            """.data(using: String.Encoding.utf8) ?? Data()
            struct Root: Codable, DecodeValueMappable {
                let hello: String
                let world: String
                
                static func toString(decoder: PowerJSONDecoder, paths: [Path], value: JSON) throws -> String {
                    if paths.current == "[:]hello" {
                        return "!hello"
                    } else if paths.current == "[:]world" {
                        return "world"
                    }
                    return ""
                }
            }
            let json = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(json.hello, "!hello")
            XCTAssertEqual(json.world, "world")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}, "", "dfadfad"]
                """.data(using: String.Encoding.utf8) ?? Data()
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
