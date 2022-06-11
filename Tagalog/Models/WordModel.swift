//
//  WordModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/13.
//

import Foundation

class Word: Codable, JsonData{
    var tagalog      : String
    var japanese     : String
    var partsOfSpeech: String
}

extension Word{
    typealias SelfType = Word
    
    class func getFromJson() -> [SelfType] {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else{
            fatalError("Cannot find the file")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Error on reading file")
        }
        
        let decoder = JSONDecoder()
        return try! decoder.decode([Word].self, from: data)
    }
    
    class func searchOneByString(str: String) -> Word?{
        let wordsFromJson = Word.getFromJson()
        
        var word = wordsFromJson.filter{
            let pattern = "^" + $0.tagalog + "(ng$|g$|$)"
            let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            if regex.firstMatch(in: str, options: [], range: NSRange(0..<str.count)) != nil{
                return true
            }
            return false
        }.first
        
        if word != nil{
            return word
        }
        
        let verbsFromJson = Verb.getFromJson()
        let verb = verbsFromJson.filter{
            if $0.completed == str || $0.uncompleted == str || $0.unstarted == str || $0.root == str{
                return true
            }
            return false
        }.first
            
        if verb != nil{
            word = wordsFromJson.filter{ $0.tagalog == verb!.infinitive }.first
        }
        
        return word
    }
    
    func createRegexPattern() -> String{
        if self.partsOfSpeech != "動"{
            return "(^| )" + self.tagalog + "(ng |g |[^a-z])"
        }
        
        let verbsFromJson = Verb.getFromJson()
        if let verb = verbsFromJson.filter({ $0.infinitive == self.tagalog }).first{
            return "(^| )(" + self.tagalog + "|" + verb.completed + "|" + verb.uncompleted + "|" +
                                    verb.unstarted + "|paki" + verb.root + "|magpa" + verb.root + ")[^a-z]"
        }
        
        return "(^| )" + self.tagalog + "[^a-z]"
    }
    
    func searchExamplesByPattern(pattern: String) -> [Example]{
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let examplesFromJson = Example.getFromJson()
        
        return examplesFromJson.filter{
            if regex.firstMatch(in: $0.tagalog, options: [], range: NSRange(0..<$0.tagalog.count)) != nil{
                return true
            }else{
                return false
            }
        }
    }
}


