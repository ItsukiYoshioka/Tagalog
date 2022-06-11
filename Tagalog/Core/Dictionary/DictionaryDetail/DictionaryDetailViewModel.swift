//
//  DictionaryDetailViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/08.
//

import Foundation

class DictionaryDetailViewModel: ObservableObject{
    private var word      : Word?
    private var sameWords : [Word]    = []
    private var examples  : [Example] = []
    
    @Published private var _isWordFavorite     : Bool      = false
    @Published private var _isExampleFavorites : [Bool]    = []
    
    var isWordNil: Bool{
        if self.word == nil{
            return true
        }
        return false
    }
    
    var wordTagalog: String{
        self.word!.tagalog
    }
    
    var wordJapanese: String{
        self.word!.japanese
    }
    
    var wordPartsOfSpeech: String{
        self.word!.partsOfSpeech
    }
    
    var sameWordJapaneses: [String]{
        self.sameWords.map{ $0.japanese }
    }
    
    var sameWordPartsOfSpeeches: [String]{
        self.sameWords.map{ $0.partsOfSpeech }
    }
    
    var exampleTagalogs: [String]{
        self.examples.map{ $0.tagalog }
    }
    
    var exampleJapaneses: [String]{
        self.examples.map{ $0.japanese }
    }
    
    var isWordFavorite: Bool{
        self._isWordFavorite
    }
    
    var isExampleFavorites: [Bool]{
        self._isExampleFavorites
    }
    
    init(word: Word?){
        if let word = word{
            self.word = word
            self.examples = word.searchExamplesByPattern(pattern: word.createRegexPattern())
            self._isWordFavorite = RealmManager.checkWordIsFavorite(tagalog: word.tagalog)
            self.setExampleFavorites()
        }
    }
}

//お気に入り系の関数
extension DictionaryDetailViewModel{
    private func setExampleFavorites(){
        let exampleIds = self.examples.map{ RealmManager.makeExampleId(example: $0) }
        self._isExampleFavorites = exampleIds.map{ (exampleId) -> Bool in
            if RealmManager.searchFavoritePhraseFromRealm(id: exampleId) != nil{
                return true
            }
            return false
        }
    }
    
    func toggleWordFavorite(){
        if self._isWordFavorite{
            if let favoriteWord = RealmManager.searchFavoriteWordFromRealm(tagalog: self.wordTagalog){
                RealmManager.deleteFromRealm(data: favoriteWord)
                self._isWordFavorite = false
            }
        }else{
            RealmManager.addNewFavoriteWordToRealm(tagalog: self.wordTagalog)
            self._isWordFavorite = true
        }
    }
    
    func toggleExampleFavorite(index: Int){
        let exampleId = RealmManager.makeExampleId(example: self.examples[index])
        if self._isExampleFavorites[index]{
            if let favoriteExample = RealmManager.searchFavoritePhraseFromRealm(id: exampleId){
                RealmManager.deleteFromRealm(data: favoriteExample)
                self._isExampleFavorites[index] = false
            }
        }else{
            RealmManager.addNewFavoritePhraseToRealm(id: exampleId)
            self._isExampleFavorites[index] = true
        }
    }
}

//履歴系の関数
extension DictionaryDetailViewModel{
    func updateWordHistory(){
        if let target = RealmManager.searchWordHistroyFromRealm(tagalog: self.wordTagalog){
            RealmManager.updateWordHistoryInRealm(wordHisory: target)
        }else{
            RealmManager.addNewWordHistoryToRealm(tagalog: self.wordTagalog)
        }
    }
}
