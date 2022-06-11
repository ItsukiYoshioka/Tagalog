//
//  QuizDataViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/17.
//

import Foundation

class QuizDataViewModel{
    private var wordQuizData      : Quiz?
    private var sentenceQuizData  : Quiz?
    private var wordOrderQuizData : Quiz?
    private var verbQuizData      : Quiz?
    
    init(){
        self.wordQuizData = RealmManager.searchQuizDataFromRealm(quizType: .wordQuiz)
        self.sentenceQuizData = RealmManager.searchQuizDataFromRealm(quizType: .sentenceQuiz)
        self.wordOrderQuizData = RealmManager.searchQuizDataFromRealm(quizType: .wordOrderQuiz)
        self.verbQuizData = RealmManager.searchQuizDataFromRealm(quizType: .verbQuiz)
    }
}

extension QuizDataViewModel{
    func totalNum(quizType: Constants.quizType? = nil) -> Int{
        switch quizType{
        case .wordQuiz:
            if self.wordQuizData == nil{
                return 0
            }else{
                return self.wordQuizData!.totalNum
            }
        case .sentenceQuiz:
            if self.sentenceQuizData == nil{
                return 0
            }else{
                return self.sentenceQuizData!.totalNum
            }
        case .wordOrderQuiz:
            if self.wordOrderQuizData == nil{
                return 0
            }else{
                return self.wordOrderQuizData!.totalNum
            }
        case .verbQuiz:
            if self.verbQuizData == nil{
                return 0
            }else{
                return self.verbQuizData!.totalNum
            }
        default:
            return self.addTotalNum()
        }
    }
    
    func correctNum(quizType: Constants.quizType? = nil) -> Int{
        switch quizType{
        case .wordQuiz:
            if self.wordQuizData == nil{
                return 0
            }else{
                return self.wordQuizData!.correctNum
            }
        case .sentenceQuiz:
            if self.sentenceQuizData == nil{
                return 0
            }else{
                return self.sentenceQuizData!.correctNum
            }
        case .wordOrderQuiz:
            if self.wordOrderQuizData == nil{
                return 0
            }else{
                return self.wordOrderQuizData!.correctNum
            }
        case .verbQuiz:
            if self.verbQuizData == nil{
                return 0
            }else{
                return self.verbQuizData!.correctNum
            }
        default:
            return self.addCorrectNum()
        }
    }
    
    private func addTotalNum() -> Int{
        var totalNum = 0
        
        if let wordQuiz = self.wordQuizData{
            totalNum += wordQuiz.totalNum
        }
        if let sentenceQuiz = self.sentenceQuizData{
            totalNum += sentenceQuiz.totalNum
        }
        if let wordOrder = self.wordOrderQuizData{
            totalNum += wordOrder.totalNum
        }
        if let verb = self.verbQuizData{
            totalNum += verb.totalNum
        }
        
        return totalNum
    }
    
    private func addCorrectNum() -> Int{
        var correctNum = 0
        
        if let wordQuiz = self.wordQuizData{
            correctNum += wordQuiz.correctNum
        }
        if let sentenceQuiz = self.sentenceQuizData{
            correctNum += sentenceQuiz.correctNum
        }
        if let wordOrder = self.wordOrderQuizData{
            correctNum += wordOrder.correctNum
        }
        if let verb = self.verbQuizData{
            correctNum += verb.correctNum
        }
        
        return correctNum
    }
}
