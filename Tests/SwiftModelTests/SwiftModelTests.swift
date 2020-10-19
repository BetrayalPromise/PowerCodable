import XCTest
@testable import SwiftModel

final class SwiftModelDecodeTests: XCTestCase {
    func testBool() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}, "", "dfadfad"]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }

        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testInt() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testInt8() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testInt16() {
        do {
            let data: Data = #"""
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """#.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testInt32() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testInt64() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testUInt() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testUInt8() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testUInt16() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testUInt32() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testUInt64() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testFloat() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testDouble() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testString() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
                XCTFail("error")
            }
        }
    }

    func testArray() {
        do {
            let data: Data = """
                []
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
            do {
                let model = try decoder.decode(type: [Bool].self, from: data) 
                XCTAssertEqual(model.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            struct Root: Codable {
                var abc: String?
                var info: [Bool]?
            }
            let data: Data = """
                {"info": [], "abc": ""}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
            do {
                let model = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model.info?.count, 0)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testDictionary() {
        do {
            struct Root: Codable, MappingDecodingKeys {
                static func modelDecodingKeys() -> [String: [String]] {
                    return ["info": ["a", "b"], "b": ["b"]]
                }
                let info: Bool
                let b: String
            }
            let data: Data = """
                {"a": true, "b": ""}
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
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
            let decoder = PowerJSONDecoder()

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

    func testWrapperIgnore() {
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
            var data: String? = nil
        }
        let decoder: PowerJSONDecoder = PowerJSONDecoder()
        let model = try? decoder.decode(type: Information.self, from: data)
        XCTAssertEqual(model?.name, "10JQKA")
        XCTAssertEqual(model?.info, nil)
        print(model?.data ?? "")
    }

    func testMapping() {
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
            let decoder = PowerJSONDecoder()
            do {
                let model: A? = try decoder.decode(type: A.self, from: data)
                XCTAssert((model?.a[0]?.gender ?? Gender.unknow) == Gender.male)
                XCTAssert((model?.a[1]?.gender ?? Gender.unknow) == Gender.female)
                XCTAssert((model?.a[2]?.gender ?? Gender.unknow) == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        do {
            struct Adapter: TypeConvertible {
                func toInt(path: JSONPath, value: JSONInteger) -> Int {
                    if path == "[:]gender" && value == 4 {
                        return 0
                    }
                    return Int(value)
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
            let decoder: PowerJSONDecoder = PowerJSONDecoder()
            decoder.valueConvertTypeStrategy = .useCustom(Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            struct Adapter: TypeConvertible {
                func toInt(path: JSONPath, value: JSONFloating) -> Int {
                    if path == "[:]gender" && value == 3.5 {
                        return 0
                    }
                    return Int(value)
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
            let decoder: PowerJSONDecoder = PowerJSONDecoder()
            decoder.valueConvertTypeStrategy = .useCustom(Adapter())
            do {
                let model: Human? = try decoder.decode(type: Human.self, from: data)
                XCTAssert(model?.gender == Gender.unknow)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }

        do {
            struct Adapter: TypeConvertible {
                func toInt(path: JSONPath, value: JSONInteger) -> Int {
                    if path == "[:]gender" && value > 2 {
                        return 0
                    }
                    return Int(value)
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

            let decoder: PowerJSONDecoder = PowerJSONDecoder()
            decoder.valueConvertTypeStrategy = .useCustom(Adapter())
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
        age?.path()
        json?.path()
    }

    func testNested() {
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

            let decoder: PowerJSONDecoder = PowerJSONDecoder()
            do {
                let model: Root? = try decoder.decode(type: Root.self, from: data)
                XCTAssertEqual(model?.a[0].b[0].c[0].d[0].c, "over")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

    func testURL() {
        let data: Data = """
        {
            "baidubaibaidu": "http://192.168.0.103"
        }
        """.data(using: String.Encoding.utf8) ?? Data()
        struct Root :Codable, MappingDecodingKeys {
            let baidu: URL

            static func modelDecodingKeys() -> [String: [String]] {
                return ["baidu": ["baidubaibaidu", "baidu"]]
            }
        }
        let decoder: PowerJSONDecoder = PowerJSONDecoder()
        do {
            let model: Root = try decoder.decode(type: Root.self, from: data)
            XCTAssertEqual(model.baidu.absoluteString, "http://192.168.0.103")
            print(model.baidu)
        } catch {
            XCTAssertNil(error, error.localizedDescription)
        }
    }
}

final class SwiftModelEncodeTests: XCTestCase {
    func testEncode()  {
        struct A : Encodable, MappingEncodingKeys {
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
            static func modelEncodingKeys() -> [String: String] {
                return ["string": "hello"]
            }
//            static func modelEncodingValues(path: JSONPath, ) -> String {

//            }
//            static func modelEncodingValues(path: JSONPath, value: JSON) -> JSON {
//                if path == "[:]bool" {
//                    return JSON(integerLiteral: 3)
//                }
//                return value
//            }
        }
        let a = A()
        let encoder = PowerJSONEncoder()
        do {
            let string: String = try encoder.encode(value: a, to: String.self)
            print(string)
            XCTAssertNotEqual(string, "error")
        } catch  {
            XCTFail("解析失败")
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
        let encoder = PowerJSONEncoder()
        let root = Root()
        do {
            let data: String = try encoder.encode(value: root, to: String.self)
            print(data)
            XCTAssertNotEqual(data, "error")
        } catch  {
            XCTFail("解析失败")
        }
    }

    func testArray0() {
        let encoder = PowerJSONEncoder()
        do {
            let data: String = try encoder.encode(value: [true, false], to: String.self)
            print(data)
            XCTAssertNotEqual(data, "error")
        } catch  {
            XCTFail("解析失败")
        }
    }

    func testArray1() {
        let encoder = PowerJSONEncoder()
        do {
            let data: String = try encoder.encode(value: [[true, true], [false]], to: String.self)
            print(data)
            XCTAssertNotEqual(data, "error")
        } catch  {
            XCTFail("解析失败")
        }
    }

    func testArray2() {
        struct Root: Encodable {
            var `as`: [[A]] = [[A(), A()]]
        }
        struct A: Encodable {
            var bool = false
        }

        let encoder = PowerJSONEncoder()
        do {
            let data: String = try encoder.encode(value: Root(), to: String.self)
            print(data)
            XCTAssertNotEqual(data, "error")
        } catch  {
            XCTFail("解析失败")
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
        let encoder = PowerJSONEncoder()
        let root = Root()
        do {
            let string: String = try encoder.encode(value: root, to: String.self)
            print(string)
            XCTAssertNotEqual(string, "error")
        } catch  {
            XCTFail("解析失败")
        }
    }

    func testURL() {
        do {
            struct Root :Codable, MappingEncodingKeys {
                let baidu: URL = URL(safe: "http://www.baidu.com")

                static func modelEncodingKeys() -> [String: String] {
                    return ["baidu": "google"]
                }

            }
            let encoder: PowerJSONEncoder = PowerJSONEncoder()
            do {
                let model: Any = try encoder.encode(value: Root(), to: JSON.self)
                print(model)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
        do {
            let encoder: PowerJSONEncoder = PowerJSONEncoder()
            do {
                let model: Any = try encoder.encode(value: [URL(safe: "http://www.baidu.com"), URL(safe: "http://www.baidu.com")], to: JSON.self)
                print(model)
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }
}
