//
//  VerbDetailViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/11.
//

import Foundation

class VerbDetailViewModel{
    private var verb: Verb?
    
    var reflectedVerbs: [String]{
        var rv: [String] = []
        
        rv.append(self.verb!.root)
        rv.append(self.verb!.infinitive)
        rv.append(self.verb!.completed)
        rv.append(self.verb!.uncompleted)
        rv.append(self.verb!.unstarted)
        
        return rv
    }
    
    var reflections: [String]{
        var r: [String] = []
        
        r.append(Constants.verbReflections.root.rawValue)
        r.append(Constants.verbReflections.infinitive.rawValue)
        r.append(Constants.verbReflections.completed.rawValue)
        r.append(Constants.verbReflections.uncompleted.rawValue)
        r.append(Constants.verbReflections.unstarted.rawValue)
        
        return r
    }
    
    var japanese: String{
        self.verb!.japanese
    }
    
    var focus: String{
        if self.verb!.focus == "A"{
            return "行為者フォーカス"
        }
        return "非行為者フォーカス"
    }
    
    var type: String{
        self.verb!.type
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        let word = Word.searchOneByString(str: self.verb!.infinitive)
        return DictionaryDetailViewModel(word: word)
    }
    
    init(verb: Verb?){
        self.verb = verb
    }
}
