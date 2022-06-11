//
//  VerbModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/19.
//

import Foundation

class Verb: Codable, JsonData{
    var root        : String
    var infinitive  : String
    var completed   : String
    var uncompleted : String
    var unstarted   : String
    var japanese    : String
    var focus       : String
    var type        : String
}

extension Verb{
    typealias SelfType = Verb
    
    class func getFromJson() -> [Verb] {
        guard let url = Bundle.main.url(forResource: "verbs", withExtension: "json") else{
            fatalError("Cannot find the file")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Error on reading file")
        }
        
        let decoder = JSONDecoder()
        return try! decoder.decode([Verb].self, from: data)
    }
}
