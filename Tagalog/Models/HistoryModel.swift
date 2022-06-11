//
//  HistoryModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/31.
//

import Foundation
import RealmSwift

class WordHistory: Object{
    @objc dynamic var tagalog        : String = ""
    @objc dynamic var count          : Int    = 1
    @objc dynamic var lastAccessDate : Date   = Date()
}
