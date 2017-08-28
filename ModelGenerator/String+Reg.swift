//
//  File.swift
//  ModelGenerator
//
//  Created by Aqua on 2017/8/25.
//  Copyright © 2017年 Aqua. All rights reserved.
//

import Foundation

extension String {
    

    func replace(regExp: String, with replace: String) -> String {
        
        let reg = try? NSRegularExpression(pattern: regExp, options: .caseInsensitive)
        let mutableSelf = NSMutableString(string: self)
        reg?.replaceMatches(in: mutableSelf,
                            options: [],
                            range: NSRange(location: 0, length: self.utf16.count),
                            withTemplate: replace)
        
        return mutableSelf as String
    }
    
    mutating func removeHttpString() {
        self = replace(regExp: "\"http.*//.*\"", with: "\"\"")
    }
    
    mutating func removeComment() {
        self = replace(regExp: "//.*\n", with: "\n")
    }
    
    var lowerCamelCase: String {
        let words = components(separatedBy: "_")
        return words.enumerated()
            .reduce("")
            { (result, element: (offset: Int, word: String)) -> String in
                var s = element.word
                if element.offset != 0 {
                    s = s.capitalized
                }
                return result + s
            }
    }
    
}

