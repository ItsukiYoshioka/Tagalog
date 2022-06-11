//
//  MemoAddViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/19.
//

import Foundation

class MemoAddViewModel{
    func storeMemo(title: String, contents: String){
        RealmManager.addNewMemoToRealm(title: title, contents: contents)
    }
}
