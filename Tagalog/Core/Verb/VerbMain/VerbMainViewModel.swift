//
//  VerbMainViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/19.
//

import Foundation

class VerbMainViewModel: ObservableObject{
    private var searchedVerbs           : [Verb]                      = []
    private var searchedVerbReflections : [Constants.verbReflections] = []
    
    @Published var selectedVerb: Verb?
    
    var tagalogs: [String]{
        var tgs: [String] = []
        for i in 0..<searchedVerbs.count{
            tgs.append(self.getTagalogByReflection(index: i))
        }
        return tgs
    }
    
    var japaneses: [String]{
        self.searchedVerbs.map{ $0.japanese }
    }
    
    var reflections: [String]{
        self.searchedVerbReflections.map{ $0.rawValue }
    }
    
    var verbDetailViewModel: VerbDetailViewModel{
        VerbDetailViewModel(verb: self.selectedVerb)
    }
}

extension VerbMainViewModel{
    private func getTagalogByReflection(index: Int) -> String{
        if self.searchedVerbReflections[index] == .infinitive{
            return self.searchedVerbs[index].infinitive
        }
        if self.searchedVerbReflections[index] == .completed{
            return self.searchedVerbs[index].completed
        }
        if self.searchedVerbReflections[index] == .uncompleted{
            return self.searchedVerbs[index].uncompleted
        }
        return self.searchedVerbs[index].unstarted
    }
    
    func getForcus() -> String{
        if self.selectedVerb!.focus == "A"{
            return "行為者フォーカス"
        }else{
            return "非行為者フォーカス"
        }
    }
    
    func getType() -> String{
        return selectedVerb!.type
    }
}

extension VerbMainViewModel{
    func searchVerbs(searchText: String, dictionaryKind: Constants.dictionaryKind, searchPattern: Constants.searchPattern) -> Bool{
        if searchText.isEmpty{
            self.searchedVerbs = []
            self.searchedVerbReflections = []
            return false
        }
        
        var pattern = ""
        
        if searchPattern == .startWith{
            pattern = "^" + searchText + ".*"
        }else{
            pattern = searchText
        }
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let verbsFromJson = Verb.getFromJson()
        
        if dictionaryKind == .tagalogToJapanese{
            for i in 0..<verbsFromJson.count{
                let v = verbsFromJson[i]
                if regex.firstMatch(in: v.infinitive, options: [], range: NSRange(0..<v.infinitive.count)) != nil{
                    self.searchedVerbs.append(v)
                    self.searchedVerbReflections.append(.infinitive)
                }
                if regex.firstMatch(in: v.completed, options: [], range: NSRange(0..<v.completed.count)) != nil{
                    self.searchedVerbs.append(v)
                    self.searchedVerbReflections.append(.completed)
                }
                if regex.firstMatch(in: v.uncompleted, options: [], range: NSRange(0..<v.uncompleted.count)) != nil{
                    self.searchedVerbs.append(v)
                    self.searchedVerbReflections.append(.uncompleted)
                }
                if regex.firstMatch(in: v.unstarted, options: [], range: NSRange(0..<v.unstarted.count)) != nil{
                    self.searchedVerbs.append(v)
                    self.searchedVerbReflections.append(.unstarted)
                }
            }
        }else{
            self.searchedVerbs = verbsFromJson.filter{
                if regex.firstMatch(in: $0.japanese, options: [], range: NSRange(0..<$0.japanese.count)) != nil{
                    return true
                }else{
                    return false
                }
            }
            self.searchedVerbs.sort{ $0.japanese < $1.japanese }
        }
        
        if self.searchedVerbs.isEmpty{
            return false
        }
        
        return true
    }
    
    func setSelectedVerb(index: Int){
        self.selectedVerb = self.searchedVerbs[index]
    }
}
