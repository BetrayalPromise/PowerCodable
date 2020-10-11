import XCTest
@testable import SwiftModel

final class SwiftModelTests: XCTestCase {
    func testBool() {
        do {
            let data: Data = """
                [true, false, 0, 1, 2, 3, 4.5, -6.7, null, [], [null], [true], [false], [0], [1], [2], [3], [4.5], [6.7], {}, {"a": "b"}, "", "dfadfad"]
            """.data(using: String.Encoding.utf8) ?? Data()
            let decoder = PowerJSONDecoder()
            do {
                let models: [Bool] = try decoder.decode(type: [Bool].self, fromData: data)
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
                XCTAssertEqual(models[22], false)
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
                let models: [Bool?] = try decoder.decode(type: [Bool?].self, fromData: data)
                XCTAssertEqual(models[0], true)
                XCTAssertEqual(models[1], false)
                XCTAssertEqual(models[2], false)
                XCTAssertEqual(models[3], true)
                XCTAssertEqual(models[4], false)
                XCTAssertEqual(models[5], false)
                XCTAssertEqual(models[6], false)
                XCTAssertEqual(models[7], false)
                XCTAssertEqual(models[8], nil)
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
                let models: [Int] = try decoder.decode(type: [Int].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int?] = try decoder.decode(type: [Int?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int8] = try decoder.decode(type: [Int8].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int8?] = try decoder.decode(type: [Int8?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int16] = try decoder.decode(type: [Int16].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int16?] = try decoder.decode(type: [Int16?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int32] = try decoder.decode(type: [Int32].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int32?] = try decoder.decode(type: [Int32?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int64] = try decoder.decode(type: [Int64].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Int64?] = try decoder.decode(type: [Int64?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], -6)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt] = try decoder.decode(type: [UInt].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt?] = try decoder.decode(type: [UInt?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt8] = try decoder.decode(type: [UInt8].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt8?] = try decoder.decode(type: [UInt8?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt16] = try decoder.decode(type: [UInt16].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt16?] = try decoder.decode(type: [UInt16?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt32] = try decoder.decode(type: [UInt32].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt32?] = try decoder.decode(type: [UInt32?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt64] = try decoder.decode(type: [UInt64].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [UInt64?] = try decoder.decode(type: [UInt64?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4)
                XCTAssertEqual(models[7], 0)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Float] = try decoder.decode(type: [Float].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4.5)
                XCTAssertEqual(models[7], -6.7)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Float?] = try decoder.decode(type: [Float?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4.5)
                XCTAssertEqual(models[7], -6.7)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Double] = try decoder.decode(type: [Double].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4.5)
                XCTAssertEqual(models[7], -6.7)
                XCTAssertEqual(models[8], 0)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [Double?] = try decoder.decode(type: [Double?].self, fromData: data)
                XCTAssertEqual(models[0], 1)
                XCTAssertEqual(models[1], 0)
                XCTAssertEqual(models[2], 0)
                XCTAssertEqual(models[3], 1)
                XCTAssertEqual(models[4], 2)
                XCTAssertEqual(models[5], 3)
                XCTAssertEqual(models[6], 4.5)
                XCTAssertEqual(models[7], -6.7)
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], 0)
                XCTAssertEqual(models[10], 0)
                XCTAssertEqual(models[11], 0)
                XCTAssertEqual(models[12], 0)
                XCTAssertEqual(models[13], 0)
                XCTAssertEqual(models[14], 0)
                XCTAssertEqual(models[15], 0)
                XCTAssertEqual(models[16], 0)
                XCTAssertEqual(models[17], 0)
                XCTAssertEqual(models[18], 0)
                XCTAssertEqual(models[19], 0)
                XCTAssertEqual(models[20], 0)
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
                let models: [String] = try decoder.decode(type: [String].self, fromData: data)
                XCTAssertEqual(models[0], "true")
                XCTAssertEqual(models[1], "false")
                XCTAssertEqual(models[2], "0")
                XCTAssertEqual(models[3], "1")
                XCTAssertEqual(models[4], "2")
                XCTAssertEqual(models[5], "3")
                XCTAssertEqual(models[6], "4.5")
                XCTAssertEqual(models[7], "-6.7")
                XCTAssertEqual(models[8], "null")
                XCTAssertEqual(models[9], "[]")
                XCTAssertEqual(models[10], "[]")
                XCTAssertEqual(models[11], "[]")
                XCTAssertEqual(models[12], "[]")
                XCTAssertEqual(models[13], "[]")
                XCTAssertEqual(models[14], "[]")
                XCTAssertEqual(models[15], "[]")
                XCTAssertEqual(models[16], "[]")
                XCTAssertEqual(models[17], "[]")
                XCTAssertEqual(models[18], "[]")
                XCTAssertEqual(models[19], "[:]")
                XCTAssertEqual(models[20], "[:]")
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
                let models: [String?] = try decoder.decode(type: [String?].self, fromData: data)
                XCTAssertEqual(models[0], "true")
                XCTAssertEqual(models[1], "false")
                XCTAssertEqual(models[2], "0")
                XCTAssertEqual(models[3], "1")
                XCTAssertEqual(models[4], "2")
                XCTAssertEqual(models[5], "3")
                XCTAssertEqual(models[6], "4.5")
                XCTAssertEqual(models[7], "-6.7")
                XCTAssertEqual(models[8], nil)
                XCTAssertEqual(models[9], "[]")
                XCTAssertEqual(models[10], "[]")
                XCTAssertEqual(models[11], "[]")
                XCTAssertEqual(models[12], "[]")
                XCTAssertEqual(models[13], "[]")
                XCTAssertEqual(models[14], "[]")
                XCTAssertEqual(models[15], "[]")
                XCTAssertEqual(models[16], "[]")
                XCTAssertEqual(models[17], "[]")
                XCTAssertEqual(models[18], "[]")
                XCTAssertEqual(models[19], "[:]")
                XCTAssertEqual(models[20], "[:]")
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
                let models = try decoder.decode(type: [Bool].self, fromData: data)
                XCTAssertEqual(models.count, 0)
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
                let models = try decoder.decode(type: Root.self, fromData: data)
                XCTAssertEqual(models.info?.count, 0)
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
                let models = try decoder.decode(type: Root.self, fromData: data)
                XCTAssertEqual(models.info, true)
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
                let model: Root = try decoder.decode(type: Root.self, fromData: data)
                XCTAssert(model.key?.key?.key == "key")
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
        let model = try? decoder.decode(type: Information.self, fromData: data)
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
                let models: A = try decoder.decode(type: A.self, fromData: data)
                XCTAssert((models.a[0]?.gender ?? Gender.unknow) == Gender.male)
                XCTAssert((models.a[1]?.gender ?? Gender.unknow) == Gender.female)
                XCTAssert((models.a[2]?.gender ?? Gender.unknow) == Gender.unknow)
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
                let models: Human = try decoder.decode(type: Human.self, fromData: data)
                XCTAssert(models.gender == Gender.unknow)
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
                let models: Human = try decoder.decode(type: Human.self, fromData: data)
                XCTAssert(models.gender == Gender.unknow)
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
                let models: Human = try decoder.decode(type: Human.self, fromData: data)
                XCTAssert(models.gender == Gender.unknow)
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
        let json = try? data.toJSON()
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
                let models: Root = try decoder.decode(type: Root.self, fromData: data)
                XCTAssertEqual(models.a[0].b[0].c[0].d[0].c, "over")
            } catch {
                XCTAssertNil(error, error.localizedDescription)
            }
        }
    }

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
        let data = try? encoder.encodeToData(value: a)
        print(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "error")
    }

//    func testEncodeArray() {
//        struct A: Encodable {
//            var bool = false
//        }
//        let encoder = PowerJSONEncoder()
//        let data = try? encoder.encodeToData(value: [A(), A()])
//        print(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "error")
//    }
}
