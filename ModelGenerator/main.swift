//
//  main.swift
//  ModelGenerator
//
//  Created by Aqua on 25/08/2017.
//  Copyright © 2017 Aqua. All rights reserved.
//

import Foundation

typealias JsonObject = [String: Any]

let currentPath = Bundle.main.bundlePath

/************************************/

struct Path {
    static var json     = "\(currentPath)/response.json"
    static var template = "\(currentPath)/template.mustache"
    static var result   = "\(currentPath)/Result.swift"
}
 
/************************************/


enum OperationError : Error {
    case jsonStringIsNil
}


let urlString = Path.json /// json url
let url = URL(fileURLWithPath: urlString)

var jsonString: String?

do {
    let data = try Data(contentsOf: url)
    jsonString = String(data: data, encoding: .utf8)

} catch {
    print("********************************")
    print("当前目录下未发现response.json文件")
    print("********************************")
}

guard let jsonString = jsonString else {
    throw OperationError.jsonStringIsNil
}


var renderObject = MustacheMapper(jsonString: jsonString).renderObject()

do {
    let template = try Template(path: Path.template) /// 模版url
    let result = try template.render(renderObject)
    /// 结果url
    let resultPath = Path.result
    if !FileManager.default.fileExists(atPath: resultPath) {
        FileManager.default.createFile(atPath: resultPath, contents: nil, attributes: nil)
    }
    try result.write(toFile: resultPath, atomically: true, encoding: .utf8)
    print("model已生成，请见当前目录下的Result.swift")
} catch {
    print(error)
}

