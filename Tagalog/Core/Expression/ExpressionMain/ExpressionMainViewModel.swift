//
//  ExpressionMainViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/11.
//

import Foundation

class ExpressionMainViewModel: ObservableObject{
    @Published private var selectedTitle: String?
    
    var titles: [String]{
        Expression.getFromJson().map{ $0.title }.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
    }
    
    var expressionListViewModel: ExpressionListViewModel{
        ExpressionListViewModel(title: self.selectedTitle)
    }
}

extension ExpressionMainViewModel{
    func setSelectedTitle(title: String){
        self.selectedTitle = title
    }
}
