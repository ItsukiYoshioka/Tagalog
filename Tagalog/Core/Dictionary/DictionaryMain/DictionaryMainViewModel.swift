//
//  DictionaryMainViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/14.
//

import Foundation

class DictionaryMainViewModel: ObservableObject{
    private var searchedWords : [Word] = []
    
    @Published private var selectedWord : Word?
    
    var tagalogs: [String]{
        self.searchedWords.map{ $0.tagalog }
    }
    
    var japaneses: [String]{
        self.searchedWords.map{ $0.japanese }
    }
    
    var partsOfSpeeches: [String]{
        self.searchedWords.map{ $0.partsOfSpeech }
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        DictionaryDetailViewModel(word: self.selectedWord)
    }
}

extension DictionaryMainViewModel{
    //語を検索する関数。
    //<return>true: 検索結果あり, false: 検索結果なし</return>
    func searchWords(searchText: String, dictionaryKind: Constants.dictionaryKind, searchPattern: Constants.searchPattern) -> Bool{
        if searchText.isEmpty{
            self.searchedWords = []
            return false
        }
        
        var pattern = ""
        
        if searchPattern == .startWith{
            pattern = "^" + searchText + ".*"
        }else{
            pattern = searchText
        }
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let wordsFromJson = Word.getFromJson()
        
        if dictionaryKind == .tagalogToJapanese{
            self.searchedWords = wordsFromJson.filter{
                if regex.firstMatch(in: $0.tagalog, options: [], range: NSRange(0..<$0.tagalog.count)) != nil{
                    return true
                }
                return false
            }
            searchedWords.sort{ $0.tagalog.lowercased() < $1.tagalog.lowercased() }
        }else{
            self.searchedWords = wordsFromJson.filter{
                if regex.firstMatch(in: $0.japanese, options: [], range: NSRange(0..<$0.japanese.count)) != nil{
                    return true
                }
                return false
            }
            self.searchedWords.sort{ $0.japanese < $1.japanese }
        }
        
        if self.searchedWords.isEmpty{
            return false
        }
        return true
    }
    
    func setSelectedWord(index: Int){
        self.selectedWord = self.searchedWords[index]
    }
}
