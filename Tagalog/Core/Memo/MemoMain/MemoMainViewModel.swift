//
//  MemoMainViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/06.
//

import Foundation
import RealmSwift

class MemoMainViewModel: ObservableObject{
    @Published private var memos        : [Memo] = []
    @Published private var selectedMemo : Memo?
    
    var titles: [String]{
        return self.memos.map{ $0.title }
    }
    
    var contents: [String]{
        return self.memos.map{ $0.contents }
    }
    
    var lastUpdateDate: [String]{
        return self.memos.map{ DateManager.DateToStringFmt(dt: $0.lastUpdateDate, format: "yyyy年MM月dd日") }
    }
    
    var memoEditViewModel: MemoEditViewModel{
        return MemoEditViewModel(selectedMemo: self.selectedMemo)
    }
    
    init(){
        self.refreshMemoList()
    }
}

extension MemoMainViewModel{
    func refreshMemoList(){
        self.memos.removeAll()
        self.memos = RealmManager.searchAllMemosFromRealm()
    }
    
    func setSelectedMemo(index: Int){
        self.selectedMemo = RealmManager.searchMemoFromRealm(id: self.memos[index].id)
    }
    
    func removeMemo(atOffsets: IndexSet){
        RealmManager.deleteFromRealm(data: self.memos[Array(atOffsets)[0]])
    }
}
