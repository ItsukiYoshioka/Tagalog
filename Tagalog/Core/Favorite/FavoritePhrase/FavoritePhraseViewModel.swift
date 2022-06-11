//
//  FavoritePhraseViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/11.
//

import Foundation

class FavoritePhraseViewModel: ObservableObject{
    private var favoritePhraseTagalogs   : [String]                           = []
    private var favoritePhraseJapaneses  : [String]                           = []
    private var favoritePhraseIdSuffixes : [Constants.favoritePhraseIdSuffix] = []
    
    var tagalogs: [String]{
        self.favoritePhraseTagalogs
    }
    
    var japaneses: [String]{
        self.favoritePhraseJapaneses
    }
    
    init(){
        let favoritePhrases = RealmManager.searchAllFavoritePhrasesFromRealm()
        self.favoritePhraseTagalogs = changeIdsToOriginals(favoritePhrases: favoritePhrases, isTagalog: true)
        self.favoritePhraseJapaneses = changeIdsToOriginals(favoritePhrases: favoritePhrases, isTagalog: false)
        self.favoritePhraseIdSuffixes = favoritePhrases.map{ (favoritePhrase) -> Constants.favoritePhraseIdSuffix in
            switch favoritePhrase.id.suffix(1){
            case Constants.favoritePhraseIdSuffix.example.rawValue:
                return Constants.favoritePhraseIdSuffix.example
            case Constants.favoritePhraseIdSuffix.expression.rawValue:
                return Constants.favoritePhraseIdSuffix.expression
            default:
                return Constants.favoritePhraseIdSuffix.grammer
            }
        }
    }
}

extension FavoritePhraseViewModel{
    private func changeIdsToOriginals(favoritePhrases: [FavoritePhrase], isTagalog: Bool) -> [String]{
        var originals: [String] = []
        let examplesFromJson = Example.getFromJson()
        let expressionsFromJson = Expression.getFromJson()
        
        for favoritePhrase in favoritePhrases{
            switch favoritePhrase.id.suffix(1){
            case Constants.favoritePhraseIdSuffix.example.rawValue:
                for exampleFromJson in examplesFromJson{
                    if RealmManager.makeExampleId(example: exampleFromJson) == favoritePhrase.id{
                        isTagalog ? originals.append(exampleFromJson.tagalog) : originals.append(exampleFromJson.japanese)
                        break
                    }
                }
            case Constants.favoritePhraseIdSuffix.expression.rawValue:
                for expressionFromJson in expressionsFromJson{
                    if RealmManager.makeExpressionId(expression: expressionFromJson) == favoritePhrase.id{
                        isTagalog ? originals.append(expressionFromJson.tagalog) : originals.append(expressionFromJson.japanese)
                        break
                    }
                }
            default:
                for contentsFromJson in Contents.getFromJson(){
                    for i in 0..<contentsFromJson.exampleTagalogs.count{
                        let exampleTagalog = contentsFromJson.exampleTagalogs[i]
                        let exampleJapanese = contentsFromJson.exampleJapaneses[i]
                        if RealmManager.makeGrammerExampleId(exampleTagalog: exampleTagalog, exampleJapanese: exampleJapanese) == favoritePhrase.id{
                            isTagalog ? originals.append(exampleTagalog) : originals.append(exampleJapanese)
                            break
                        }
                    }
                }
            }
        }
        
        return originals
    }
    
    func moveFavoritePhrase(fromOffsets: IndexSet, toOffset: Int){
        self.favoritePhraseTagalogs.move(fromOffsets: fromOffsets, toOffset: toOffset)
        self.favoritePhraseJapaneses.move(fromOffsets: fromOffsets, toOffset: toOffset)
        self.favoritePhraseIdSuffixes.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func removeFavoritePhrase(atOffsets: IndexSet){
        self.favoritePhraseTagalogs.remove(atOffsets: atOffsets)
        self.favoritePhraseJapaneses.remove(atOffsets: atOffsets)
        self.favoritePhraseIdSuffixes.remove(atOffsets: atOffsets)
    }
    
    func reflectChangeOnDB(){
        var favoritePhrases: [FavoritePhrase] = []
        for i in 0..<self.favoritePhraseTagalogs.count{
            let id: String
            switch self.favoritePhraseIdSuffixes[i]{
            case Constants.favoritePhraseIdSuffix.example:
                id = RealmManager.makeExampleId(example: Example.searchOneByString(tagalog: self.favoritePhraseTagalogs[i])!)
            case Constants.favoritePhraseIdSuffix.expression:
                id = RealmManager.makeExpressionId(expression: Expression.searchOneByString(tagalog: self.favoritePhraseTagalogs[i])!)
            default:
                id = RealmManager.makeGrammerExampleId(exampleTagalog: self.favoritePhraseTagalogs[i], exampleJapanese: self.favoritePhraseJapaneses[i])
            }
            favoritePhrases.append(RealmManager.searchFavoritePhraseFromRealm(id: id)!)
        }
        RealmManager.updateFavoritePhrasesInRealm(favoritePhrases: favoritePhrases)
    }
}
