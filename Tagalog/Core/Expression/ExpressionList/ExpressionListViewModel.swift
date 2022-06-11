//
//  ExpressionListViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/18.
//

import Foundation
import RealmSwift

class ExpressionListViewModel: ObservableObject{
    private var expressions: [Expression] = []
    
    @Published private var _isExpressionFavorites: [Bool] = []
    
    var title: String{
        self.expressions[0].title
    }
    
    var tagalogs: [String]{
        self.expressions.map{ $0.tagalog }
    }
    
    var japaneses: [String]{
        self.expressions.map{ $0.japanese }
    }
    
    var isExpressionFavorites: [Bool]{
        self._isExpressionFavorites
    }
    
    init(title: String?){
        if let title = title {
            self.expressions = Expression.searchSomeByTitle(title: title)
            self.setExpressionFavorites()
        }
    }
}

extension ExpressionListViewModel{
    private func setExpressionFavorites(){
        let expressionIds = self.expressions.map{ RealmManager.makeExpressionId(expression: $0) }
        self._isExpressionFavorites = expressionIds.map{ (expressionId) -> Bool in
            if RealmManager.searchFavoritePhraseFromRealm(id: expressionId) != nil{
                return true
            }
            return false
        }
    }
    
    func toggleExpressionFavorite(index: Int){
        let expressionId = RealmManager.makeExpressionId(expression: self.expressions[index])
        if self._isExpressionFavorites[index]{
            if let favoriteExpression = RealmManager.searchFavoritePhraseFromRealm(id: expressionId){
                RealmManager.deleteFromRealm(data: favoriteExpression)
                self._isExpressionFavorites[index] = false
            }
        }else{
            RealmManager.addNewFavoritePhraseToRealm(id: expressionId)
            self._isExpressionFavorites[index] = true
        }
    }
}
