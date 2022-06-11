//
//  GrammerModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/17.
//

import Foundation

class Grammer: Codable, JsonData{
    var title    : String
    var contents : [Contents]
}

struct Contents: Codable{
    var section          : String
    var description      : String
    var exampleTagalogs  : [String]
    var exampleJapaneses : [String]
}

extension Grammer{
    typealias SelfType = Grammer
    
    class func getFromJson() -> [Grammer] {
        guard let url = Bundle.main.url(forResource: "grammers", withExtension: "json") else{
            fatalError("Cannot find the file")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Error on reading file")
        }
        
        let decoder = JSONDecoder()
        return try! decoder.decode([Grammer].self, from: data)
    }
    
    class func searchOneByString(title: String) -> Grammer{
        let grammersFromJson = Grammer.getFromJson()
        return grammersFromJson.filter{ $0.title == title }.first!
    }
}

extension Contents{
    static func getFromJson() -> [Contents]{
        let grammersFromJson = Grammer.getFromJson()
        var contents: [Contents] = []
        for grammerFromJson in grammersFromJson{
            for content in grammerFromJson.contents{
                contents.append(content)
            }
        }
        return contents
    }
}
