//
//  MemoModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/18.
//

import Foundation
import RealmSwift

class Memo: Object{
    @objc dynamic var id             : String = UUID().uuidString
    @objc dynamic var title          : String = ""
    @objc dynamic var contents       : String = ""
    @objc dynamic var lastUpdateDate : Date   = Date()
    
    override static func primaryKey() -> String? {
            return "id"
        }
}
