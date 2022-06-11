//
//  MemoEditViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/18.
//

import Foundation

class MemoEditViewModel: ObservableObject{
    private var memo      : Memo?
    private var _title    : String?
    private var _contents : String?
    
    var title: String{
        get { self._title! }
        set { self._title = newValue }
    }
    
    var contents: String{
        get { self._contents! }
        set { self._contents = newValue }
    }
    
    init(selectedMemo: Memo?){
        if let memo = selectedMemo{
            self.memo = memo
            self._title = memo.title
            self._contents = memo.contents
        }
    }
}

extension MemoEditViewModel{
    func updateMemo(){
        RealmManager.updateMemoInRealm(id: self.memo!.id, title: self._title!, contents: self._contents!)
    }
}
