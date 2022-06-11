//
//  RealmManager.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/08.
//

import Foundation
import RealmSwift

class RealmManager{
    class func deleteFromRealm(data: Object){
        let realm = try! Realm()
        
        try! realm.write{
            realm.delete(data)
        }
    }
}

//お気に入り単語系
extension RealmManager{
    class func addNewFavoriteWordToRealm(tagalog: String){
        let realm = try! Realm()
        let order: Int
        
        if let last = realm.objects(FavoriteWord.self).sorted(byKeyPath: "order", ascending: true).last{
            order = last.order + 1
        }else{
            order = 0
        }
        
        try! realm.write{
            realm.create(FavoriteWord.self, value: [tagalog, order])
        }
    }
    
    class func searchFavoriteWordFromRealm(tagalog: String) -> FavoriteWord?{
        let predicate = NSPredicate(format: "tagalog == %@", tagalog)
        let realm = try! Realm()
        return realm.objects(FavoriteWord.self).filter(predicate).first
    }
    
    class func searchAllFavoriteWordsFromRealm() -> [FavoriteWord] {
        let realm = try! Realm()
        return realm.objects(FavoriteWord.self).sorted(byKeyPath: "order", ascending: true).map{ $0 }
    }
    
    class func checkWordIsFavorite(tagalog: String) -> Bool{
        let predicate = NSPredicate(format: "tagalog == %@", tagalog)
        let realm = try! Realm()
        return !realm.objects(FavoriteWord.self).filter(predicate).isEmpty
    }
    
    class func updateFavoriteWordsInRealm(favoriteWords: [FavoriteWord]){
        var favoriteWordsToBeStored: [FavoriteWord] = []
        for i in 0..<favoriteWords.count{
            let newFavoriteWord = FavoriteWord()
            newFavoriteWord.tagalog = favoriteWords[i].tagalog
            newFavoriteWord.order = i
            favoriteWordsToBeStored.append(newFavoriteWord)
        }
        let realm = try! Realm()
        let favoriteWordsToBeDeleted = realm.objects(FavoriteWord.self)
        try! realm.write{
            realm.delete(favoriteWordsToBeDeleted)
            realm.add(favoriteWordsToBeStored)
        }
    }
}

//お気に入り文章系
extension RealmManager{
    class func addNewFavoritePhraseToRealm(id: String){
        let realm = try! Realm()
        let order: Int
        
        if let last = realm.objects(FavoritePhrase.self).sorted(byKeyPath: "order", ascending: true).last{
            order = last.order + 1
        }else{
            order = 0
        }
        
        try! realm.write{
            realm.create(FavoritePhrase.self, value: [id, order])
        }
    }
    
    class func searchFavoritePhraseFromRealm(id: String) -> FavoritePhrase?{
        let predicate = NSPredicate(format: "id == %@", id)
        let realm = try! Realm()
        return realm.objects(FavoritePhrase.self).filter(predicate).first
    }
    
    class func searchAllFavoritePhrasesFromRealm() -> [FavoritePhrase] {
        let realm = try! Realm()
        return realm.objects(FavoritePhrase.self).sorted(byKeyPath: "order", ascending: true).map{ $0 }
    }
    
    class func updateFavoritePhrasesInRealm(favoritePhrases: [FavoritePhrase]){
        var favoritePhrasesToBeStored: [FavoritePhrase] = []
        for i in 0..<favoritePhrases.count{
            let newFavoritePhrase = FavoritePhrase()
            newFavoritePhrase.id = favoritePhrases[i].id
            newFavoritePhrase.order = i
            favoritePhrasesToBeStored.append(newFavoritePhrase)
        }
        let realm = try! Realm()
        let favoritePhrasesToBeDeleted = realm.objects(FavoritePhrase.self)
        try! realm.write{
            realm.delete(favoritePhrasesToBeDeleted)
            realm.add(favoritePhrasesToBeStored)
        }
    }
    
    //データをRealmに登録する際のID。文を一文格納するのは冗長なので、ハッシュ的にIDを作成する。
    class func makeExampleId(example: Example) -> String{
        let tgCount = String(example.tagalog.count)
        let jpCount = String(example.japanese.count)
        let tgPrefix = String(example.tagalog.prefix(1))
        let jpPrefix = String(example.japanese.prefix(1))
        let tgSuffix = String(example.tagalog.suffix(2))
        
        return tgCount + jpCount + tgPrefix + jpPrefix + tgSuffix + Constants.favoritePhraseIdSuffix.example.rawValue
    }
    
    class func makeExpressionId(expression: Expression) -> String{
        let tgCount = String(expression.tagalog.count)
        let jpCount = String(expression.japanese.count)
        let tgPrefix = String(expression.tagalog.prefix(1))
        let jpPrefix = String(expression.japanese.prefix(1))
        let tgSuffix = String(expression.tagalog.suffix(2))
        
        return  tgCount + jpCount + tgPrefix + jpPrefix + tgSuffix + Constants.favoritePhraseIdSuffix.expression.rawValue
    }
    
    class func makeGrammerExampleId(exampleTagalog: String, exampleJapanese: String) -> String{
        let tgCount = String(exampleTagalog.count)
        let jpCount = String(exampleJapanese.count)
        let tgPrefix = String(exampleTagalog.prefix(1))
        let jpPrefix = String(exampleJapanese.prefix(1))
        let tgSuffix = String(exampleTagalog.suffix(2))
        
        return tgCount + jpCount + tgPrefix + jpPrefix + tgSuffix + Constants.favoritePhraseIdSuffix.grammer.rawValue
    }
}

//履歴系
extension RealmManager{
    class func addNewWordHistoryToRealm(tagalog: String){
        let realm = try! Realm()
        try! realm.write{
            realm.create(WordHistory.self, value: [tagalog, 1, Date()])
        }
    }
    
    class func updateWordHistoryInRealm(wordHisory: WordHistory) {
        let realm = try! Realm()
        try! realm.write{
            wordHisory.count += 1
            wordHisory.lastAccessDate = Date()
        }
    }
    
    class func searchWordHistroyFromRealm(tagalog: String) -> WordHistory?{
        let predicate = NSPredicate(format: "tagalog == %@", tagalog)
        let realm = try! Realm()
        return realm.objects(WordHistory.self).filter(predicate).first
    }
    
    class func searchAllWordHistoriesFromRealm() -> [WordHistory]{
        let realm = try! Realm()
        return realm.objects(WordHistory.self).map{ $0 }
    }
}

//クイズ
extension RealmManager{
    class func addNewQuizDataToRealm(quizType: Constants.quizType){
        let realm = try! Realm()
        let newQuizData = Quiz()
        newQuizData.type = quizType
        try! realm.write{
            realm.add(newQuizData)
        }
    }
    
    class func updateQuizDataInRealm(quizType: Constants.quizType, isCorrect: Bool){
        let realm = try! Realm()
        let target = realm.objects(Quiz.self).filter{ $0.type == quizType }.first!
        try! realm.write{
            if isCorrect{
                target.correctNum += 1
            }
            target.totalNum += 1
        }
    }
    
    class func searchQuizDataFromRealm(quizType: Constants.quizType) -> Quiz?{
        let realm = try! Realm()
        return realm.objects(Quiz.self).filter{ $0.type == quizType }.first
    }
}

extension RealmManager{
    class func addNewMemoToRealm(title: String, contents: String){
        let realm = try! Realm()
        try! realm.write{
            realm.create(Memo.self, value: [UUID().uuidString, title, contents, Date()])
        }
    }
    
    class func updateMemoInRealm(id: String, title: String, contents: String){
        let predicate = NSPredicate(format: "id == %@", id)
        let realm = try! Realm()
        let target = realm.objects(Memo.self).filter(predicate).first!
        try! realm.write{
            target.title = title
            target.contents = contents
            target.lastUpdateDate = Date()
        }
    }
    
    class func searchMemoFromRealm(id: String) -> Memo?{
        let predicate = NSPredicate(format: "id == %@", id)
        let realm = try! Realm()
        return realm.objects(Memo.self).filter(predicate).first
    }
    
    class func searchAllMemosFromRealm() -> [Memo]{
        let realm = try! Realm()
        return realm.objects(Memo.self).map{ $0 }
    }
}
