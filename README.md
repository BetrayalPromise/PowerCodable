# SwiftModel
Analytical tools for swift

#### 1.Bool解码处理
```Swift
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
```
#### 2.Int解码处理
```Swift
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
```
#### 3.Int8解码处理(同上)
#### 4.Int16解码处理(同上)
#### 5.Int32解码处理(同上)
#### 6.Int64解码处理(同上)
#### 7.UInt解码处理(对于小于0的数据默认处理都解码为0, 也可以实现TypeConvertible协议根据需求去处理)
```Swift
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
```
#### 8.UInt8解码处理(同上)
#### 9.UInt16解码处理(同上)
#### 10.UInt32解码处理(同上)
#### 11.UInt64解码处理(同上)
#### 12.Float解码处理
```Swift
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
```
#### 13.Double解码处理(同上)
#### 14.String解码处理
```Swift
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
```
#### 15.自定义模型与JSONKey对应(常规Codable提供的CodingKey自定义,当只能一对一的转化,本工具可以实现一对多映射,因为鬼知道服务端下发的数据字段啥时候改,或者为了兼容多个字段都他妈下发过来,或者一会下发这个一会下发那个.本工具均可以处理)
```Swift
do {
    struct Root: Codable, MappingDecodingKeys {
        static func modelDecodingKeys() -> [String: [String]] {
            return ["info": ["a", "b"], "b": ["b"]]
        }
        /// 模型的info字段接受json字段("a", "b")
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
```
#### 还有写特性可见具体的Test, 
#### 感谢 [JSON](https://github.com/vdka/JSON.git) 解析功能是照搬的 并不是用Codable内部的功能(因为Codable提供的关于解析过程的比较少),壳子模仿Codable的API,使用方便,欢迎大家提PR!!!共同学习，由于底层不是Codable解析目前只支持Bool, Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64, Float, Double, String, URL其他类型会逐步加入支持
