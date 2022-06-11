//
//  QuizModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/08.
//

import Foundation
import RealmSwift

class Quiz: Object{
    @objc dynamic var quizType   : String = ""
    @objc dynamic var totalNum   : Int    = 0
    @objc dynamic var correctNum : Int    = 0
    
    var type: Constants.quizType?{
        get {
            return Constants.quizType(rawValue: self.quizType)
        }
        
        set {
            self.quizType = newValue?.rawValue ?? ""
        }
    }
}
