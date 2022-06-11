//
//  FavoriteWordViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/28.
//

import Foundation
import RealmSwift

class FavoriteWordViewModel: ObservableObject{
    private var favoriteWords: [Word]
    
    @Published private var selectedWord: Word?
    
    var tagalogs: [String]{
        self.favoriteWords.map{ $0.tagalog }
    }
    
    var japaneses: [String]{
        self.favoriteWords.map{ $0.japanese }
    }
    
    var partsOfSpeeches: [String]{
        self.favoriteWords.map{ $0.partsOfSpeech }
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        DictionaryDetailViewModel(word: self.selectedWord)
    }

    init(){
        let favoriteWords = RealmManager.searchAllFavoriteWordsFromRealm()
        self.favoriteWords = favoriteWords.map{ (favoriteWord) -> Word in
            Word.searchOneByString(str: favoriteWord.tagalog)!
        }
    }
}

extension FavoriteWordViewModel{
    func moveFavoriteWord(fromOffsets: IndexSet, toOffset: Int){
        self.favoriteWords.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func removeFavoriteWord(atOffsets: IndexSet){
        self.favoriteWords.remove(atOffsets: atOffsets)
    }
    
    func setSelectedWord(tagalog: String){
        self.selectedWord = Word.searchOneByString(str: tagalog)
    }

    func reflectChangeOnDB(){
        let favoriteWords = self.favoriteWords.map{ RealmManager.searchFavoriteWordFromRealm(tagalog: $0.tagalog)!}
        RealmManager.updateFavoriteWordsInRealm(favoriteWords: favoriteWords)
    }
}
