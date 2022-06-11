//
//  GrammerDetailViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/10.
//

import Foundation

class GrammerDetailViewModel: ObservableObject{
    private var _title   : String
    private var contents : Contents?
    
    @Published private var _isExampleFavorites : [Bool] = []
    
    var title: String{
        self._title
    }
    
    var section: String{
        self.contents!.section
    }
    
    var description: String{
        self.contents!.description
    }
    
    var tagalogs: [String]{
        self.contents!.exampleTagalogs
    }
    
    var japaneses: [String]{
        self.contents!.exampleJapaneses
    }
    
    var isExampleFavorites: [Bool]{
        self._isExampleFavorites
    }
    
    init(title: String, contents: Contents?){
        self._title = title
        self.contents = contents
        self.setExampleFavorites()
    }
}

extension GrammerDetailViewModel{
    private func setExampleFavorites(){
        if let contents = self.contents{
            var exampleIds: [String] = []
            for i in 0..<contents.exampleTagalogs.count{
                exampleIds.append(RealmManager.makeGrammerExampleId(exampleTagalog: self.tagalogs[i], exampleJapanese: self.japaneses[i]))
            }
            self._isExampleFavorites = exampleIds.map{ (exampleId) -> Bool in
                if RealmManager.searchFavoritePhraseFromRealm(id: exampleId) != nil{
                    return true
                }
                return false
            }
        }
    }
    
    func toggleExampleFavorite(index: Int){
        let exampleId = RealmManager.makeGrammerExampleId(exampleTagalog: self.tagalogs[index], exampleJapanese: self.japaneses[index])
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
