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


struct RenderKey {
    
    struct File {
        
        static var originalJson = "originalJson"
        static var models       = "models"
        
        struct Model {
            
            static var modelName  = "modelName"
            static var superClass = "superClass"
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
        parseModels(json: json, modelName: "<#name#>")
        
        models.reverse()
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

  
    fileprivate func parseModels(json: JsonObject, modelName: String) {
        
        var properties = Properties()
        modelObject(json: json, properties: &properties)
        properties.reverse()
        let model: ModelObject = [
            RenderKey.File.Model.modelName : modelName,
            RenderKey.File.Model.superClass: "Response",
            RenderKey.File.Model.properties: properties
        ]
        models.append(model)
    }
    
    fileprivate func modelObject(json: JsonObject,
                                 mapperKeyPrefix: String = "",
                                 properties: inout Properties) {
        

        json.forEach { (key, value) in
            
            if let value = value as? JsonObject {
                
                modelObject(json: value, mapperKeyPrefix: "\(key).", properties: &properties)
                
            } else if let objectArray = value as? Array<JsonObject> {
                
                if let aObject = objectArray.first {
                    let modelName = "Model\(models.count + 1)"
                    parseModels(json: aObject, modelName: modelName)
                    
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
