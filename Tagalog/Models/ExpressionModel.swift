//
//  ExpressionModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/18.
//

import Foundation

class Expression: Codable, JsonData{
    var title    : String
    var tagalog  : String
    var japanese : String
}

extension Expression{
    typealias SelfType = Expression
    
    class func getFromJson() -> [Expression] {
        guard let url = Bundle.main.url(forResource: "expressions", withExtension: "json") else{
            fatalError("Cannot find the file")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Error on reading file")
        }
        
        let decoder = JSONDecoder()
        return try! decoder.decode([Expression].self, from: data)
    }
    
    class func searchSomeByTitle(title: String) -> [Expression]{
        let expressionsFromJson = Expression.getFromJson()
        return expressionsFromJson.filter{ $0.title == title }
    }
    
    class func searchOneByString(tagalog: String) -> Expression?{
        let expressionsFromJson = Expression.getFromJson()
        return expressionsFromJson.filter{ $0.tagalog == tagalog }.first
    }
}
