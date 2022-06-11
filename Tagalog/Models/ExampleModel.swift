//
//  ExampleModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/20.
//

import Foundation

class Example:Codable, JsonData{
    var tagalog  : String
    var japanese : String
}

extension Example{
    typealias SelfType = Example
    
    class func getFromJson() -> [Example] {
        guard let url = Bundle.main.url(forResource: "examples", withExtension: "json") else{
            fatalError("Cannot find the file")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Error on reading file")
        }
        
        let decoder = JSONDecoder()
        return try! decoder.decode([Example].self, from: data)
    }
    
    class func searchOneByString(tagalog: String) -> Example?{
        let examplesFromJson = Example.getFromJson()
        return examplesFromJson.filter{ $0.tagalog == tagalog }.first
    }
}
