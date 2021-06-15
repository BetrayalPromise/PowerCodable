import XCTest
@testable import PowerCodable

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
            static func modelEncodeKeys(decoder: PowerJSONEncoder, paths: [Path]) -> [String : String] {
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
    
    func testArray() {
        do {
            let json: JSON = try encoder.encode(value: [true, false], to: JSON.self)
            XCTAssertEqual(json[0], true)
            XCTAssertEqual(json[1], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let json: JSON = try encoder.encode(value: [[true, true], [false]], to: JSON.self)
            XCTAssertEqual(json[0][0], true)
            XCTAssertEqual(json[0][1], true)
            XCTAssertEqual(json[1][0], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }

        do {
            struct Root: Encodable {
                var `as`: [[A]] = [[A(), A()]]
            }
            struct A: Encodable {
                var bool = false
            }
            let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
            XCTAssertEqual(json["as"][0][0]["bool"], false)
            XCTAssertEqual(json["as"][0][1]["bool"], false)
        } catch  {
            XCTFail(error.localizedDescription)
        }

        do {
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
                static func modelEncodeKeys(decoder: PowerJSONEncoder, paths: [Path]) -> [String : String] {
                    return ["baidu": "google"]
                }
                var baidu: URL = try! URL.buildURL(string: "http://www.baidu.com")
            }
            do {
                let json: JSON = try encoder.encode(value: Root(), to: JSON.self)
                XCTAssertEqual(json["google"], "http://www.baidu.com")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        do {
            do {
                let json: JSON = try encoder.encode(value: [URL.buildURL(string: "http://www.baidu.com"), URL.buildURL(string: "http://www.baidu.com")], to: JSON.self)
                XCTAssertEqual(json[0], "http://www.baidu.com")
                XCTAssertEqual(json[1], "http://www.baidu.com")
            } catch {
                XCTFail(error.localizedDescription)
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
                XCTFail(error.localizedDescription)
            }
        }
        do {
            do {
                let root: [Bool?]? = [true, nil]
                let model = try encoder.encode(value: root, to: String.self)
                print(model)
            } catch {
                XCTFail(error.localizedDescription)
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
        
        self.encoder.strategy.keyFormatStrategy = .useSnakeKeys(.default)
        defer {
            self.encoder.strategy.keyFormatStrategy = .useDefaultKeys
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
            static func modelEncodeKeys(decoder: PowerJSONEncoder, paths: [Path]) -> [String : String] {
                return ["boolBool": "a"]
            }
            
            var boolBool = false
        }
        
        self.encoder.strategy.keyFormatStrategy = .useSnakeKeys(.default)
        defer {
            self.encoder.strategy.keyFormatStrategy = .useDefaultKeys
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
    
    func testInfinityAndNonentity() {
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
                encoder.strategy.dataValueStrategy = .base64
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
            self.encoder.strategy.dateValueStrategy = .secondsSince1970(PowerJSONEncoder.TimestampExpressionForm.number)
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
