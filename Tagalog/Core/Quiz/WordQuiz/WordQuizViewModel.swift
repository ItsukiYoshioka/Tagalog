//
//  WordQuizViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import Foundation

class WordQuizViewModel: ObservableObject{
    private var choices         : [[Word]] = []
    private var answerPositions : [Int]    = []
    
    var selectedChoiceIndex: Int = 0
    var quizNum            : Int = 0
    var correctNum         : Int = 0
    
    var question: String{
        let ansPos = answerPositions[self.quizNum]
        return self.choices[self.quizNum][ansPos].japanese
    }
    
    var quizChoices: [String]{
        self.choices[self.quizNum].map{ $0.tagalog }
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        return DictionaryDetailViewModel(word: self.choices[self.quizNum][self.selectedChoiceIndex])
    }
    
    init(){
        self.initializeWordQuiz()
    }
}

extension WordQuizViewModel{
    func initializeWordQuiz(){
        self.choices         = []
        self.answerPositions = []
        self.quizNum         = 0
        self.correctNum      = 0
        
        var wordsFromJson = Word.getFromJson()
        wordsFromJson.shuffle()
        
        for i in 0..<10{
            self.choices.append([wordsFromJson[i*4], wordsFromJson[i*4+1], wordsFromJson[i*4+2], wordsFromJson[i*4+3]])
            let answerPos = Int.random(in: 0..<4)
            self.answerPositions.append(answerPos)
        }
        
        if RealmManager.searchQuizDataFromRealm(quizType: .wordQuiz) == nil{
            RealmManager.addNewQuizDataToRealm(quizType: .wordQuiz)
        }
    }
    
    func checkAnswer(buttonNum: Int) -> Bool{
        if buttonNum == self.answerPositions[self.quizNum]{
            return true
        }
        return false
    }
    
    func countUpIfCorrect(buttonNum: Int){
        if checkAnswer(buttonNum: buttonNum){
            self.correctNum += 1
            RealmManager.updateQuizDataInRealm(quizType: .wordQuiz, isCorrect: true)
        }else{
            RealmManager.updateQuizDataInRealm(quizType: .wordQuiz, isCorrect: false)
        }
    }
}
