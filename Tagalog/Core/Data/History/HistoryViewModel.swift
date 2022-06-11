//
//  HistoryViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/31.
//

import Foundation
import RealmSwift

class HistoryViewModel: ObservableObject{
    @Published private var wordHistories : [WordHistory]
    @Published         var viewType      : Constants.historyViewType = .wordHistory
    @Published         var ascending     : Int                       = 0
    
    var tagalogs: [String]{
        if self.viewType == .wordHistory{
            let tagalogsTmp = self.wordHistories.sorted(by: { (a, b) -> Bool in
                return self.ascending == 0 ? a.lastAccessDate > b.lastAccessDate : a.lastAccessDate < b.lastAccessDate
            })
            return tagalogsTmp.map{ $0.tagalog }
        }else{
            let tagalogsTmp = self.wordHistories.sorted(by: { (a, b) -> Bool in
                return ascending == 0 ? a.count > b.count : a.count < b.count
            })
            return tagalogsTmp.map{ $0.tagalog }
        }
    }
    
    var counts: [String]{
        let countsTmp = self.wordHistories.sorted(by: { (a, b) -> Bool in
            return ascending == 0 ? a.count > b.count : a.count < b.count
        })
        return countsTmp.map{ String($0.count) }
    }
    
    init(){
        self.wordHistories = RealmManager.searchAllWordHistoriesFromRealm()
    }
}

extension HistoryViewModel{
    func resetHistory(){
        for wordHistory in self.wordHistories{
            RealmManager.deleteFromRealm(data: wordHistory)
        }
        self.wordHistories.removeAll()
    }
}
