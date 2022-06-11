//
//  Constants.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import Foundation
import SwiftUI

class Constants{
    static let screenWidth  = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    enum dictionaryKind{
        case tagalogToJapanese
        case japaneseToTagalog
    }
    
    enum searchPattern{
        case startWith
        case includes
    }
    
    enum verbReflections: String{
        case root        = "語根"
        case infinitive  = "基本形"
        case completed   = "完了相"
        case uncompleted = "継続相"
        case unstarted   = "未然相"
    }
    
    enum favoritePhraseIdSuffix: String{
        case example    = "0"
        case expression = "1"
        case grammer    = "2"
    }
    
    enum historyViewType{
        case wordHistory
        case historyCount
    }
    
    enum quizMaxNum: Int{
        case low    = 10
        case midium = 20
        case high   = 30
    }
    
    enum quizType: String{
        case wordQuiz      = "単語クイズ"
        case sentenceQuiz  = "穴埋めクイズ"
        case wordOrderQuiz = "並べ替えクイズ"
        case verbQuiz      = "動詞活用クイズ"
    }
}
