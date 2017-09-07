//
//  MustacheMapper.swift
//  ModelGenerator
//
//  Created by Aqua on 25/08/2017.
//  Copyright © 2017 Aqua. All rights reserved.
//

import Foundation

typealias ModelObject = [String: Any]
typealias Properties  = [[String: Any]]

let ignorable = ["error_msg", "error_code"]

struct RenderKey {
    
    struct File {
        
        static var originalJson = "originalJson"
        static var models       = "models"
        
        struct Model {
            
            static var modelName  = "modelName"
            static var isSubclass = "isSubclass"
            static var properties = "properties"
            
            struct Property {
                static var name         = "name"
                static var mapperKey    = "mapperKey"
                static var type         = "type"
                static var defaultValue = "defaultValue"
            }
        }
    }
}

class MustacheMapper {

    fileprivate var jsonString: String
    
    fileprivate var models = [ModelObject]()
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
    func renderObject() -> JsonObject {
        removeComment()
        
        var renderObj = JsonObject()
        renderObj[RenderKey.File.originalJson] = jsonString
        
      
        guard let json = jsonObject() else { return renderObj }
       
        models.removeAll()
        parseModels(json: json, modelName: "<#name#>", isSubclass: true)
        
        renderObj[RenderKey.File.models] = models
        return renderObj
    }
    
    func jsonObject() -> JsonObject? {
        var jsonObject: JsonObject?
        do {
            if let data = jsonString.data(using: .utf8) {
                jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JsonObject
            }
        } catch {
            print("can not convert json string to json object")
        }
        return jsonObject
    }
}

extension MustacheMapper {
    
    func removeComment() {
        jsonString.removeHttpString()
        jsonString.removeComment()
    }
}

extension MustacheMapper {

  
    fileprivate func parseModels(json: JsonObject, modelName: String, isSubclass: Bool) {
        
        var properties = Properties()
        var model: ModelObject = [
            RenderKey.File.Model.modelName : modelName,
            RenderKey.File.Model.isSubclass: isSubclass,
        ]
        /// 先占个坑，并且记录index
        let index = models.count
        models.append(model)
        
        /// 生成model属性
        modelObject(json: json, properties: &properties)
        properties.reverse()
        model[RenderKey.File.Model.properties] = properties
        
        /// 替换原来占坑的model
        models[index] = model
    }
    
    fileprivate func modelObject(json: JsonObject,
                                 mapperKeyPrefix: String = "",
                                 properties: inout Properties) {
        

        for (key, value) in json {
            
            guard !ignorable.contains(key) else {
                continue
            }
            
            if let value = value as? JsonObject {
                
                modelObject(json: value, mapperKeyPrefix: "\(key).", properties: &properties)
                
            } else if let objectArray = value as? Array<JsonObject> {
                
                if let aObject = objectArray.first {
                    let modelName = "Model\(models.count + 1)"
                    parseModels(json: aObject, modelName: modelName, isSubclass: false)
                    
                    let propertyMap = [
                        RenderKey.File.Model.Property.name          : key.lowerCamelCase,
                        RenderKey.File.Model.Property.mapperKey     : mapperKeyPrefix + key,
                        RenderKey.File.Model.Property.type          : modelName,
                        RenderKey.File.Model.Property.defaultValue  : "[\(modelName)]()"
                    ]
                    properties.append(propertyMap)
                }
                
            } else {
                
                let propertyMap = [
                    RenderKey.File.Model.Property.name          : key.lowerCamelCase,
                    RenderKey.File.Model.Property.mapperKey     : mapperKeyPrefix + key,
                    RenderKey.File.Model.Property.type          : mapType(value),
                    RenderKey.File.Model.Property.defaultValue  : mapDefaultValue(value)
                ]
                properties.append(propertyMap)
                
            }
        }
    }
    
    fileprivate func mapDefaultValue(_ value: Any) -> Any {
        switch value {
        case is Bool :
            return false
        case is Int :
            return 0
        case is Double, is Float :
            return 0.0
        case let array as [Any]:
            return mapType(array) + "()"
        default:
            return "\"\""
        }
    }
    
    fileprivate func mapType(_ value: Any) -> String {
        switch value {
        case is Bool :
            return "Bool"
        case is Int :
            return "Int"
        case is Double, is Float :
            return "Double"
        case let array as [Any]:
            if let first =  array.first {
                return "[\(mapType(first))]"
            } else {
                return "[Any]"
            }
        default:
            return "String"
        }
    }
    
}
