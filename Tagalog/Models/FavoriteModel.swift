//
//  FavoriteModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/29.
//

import Foundation
import RealmSwift

class FavoriteWord: Object{
    @objc dynamic var tagalog : String = ""
    @objc dynamic var order   : Int    = 0
}

class FavoritePhrase: Object{
    @objc dynamic var id    : String = ""
    @objc dynamic var order : Int    = 0
}
