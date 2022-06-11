//
//  VerbQuizViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/10.
//

import Foundation

class VerbQuizViewModel: ObservableObject{
    private var verbs: [Verb] = []
    
    var quizNum    : Int = 0
    var correctNum : Int = 0
    
    var japanese: String{
        self.verbs[self.quizNum].japanese
    }
    
    var tagalogs: [String]{
        var verbTexts: [String] = []
        
        verbTexts.append(self.verbs[self.quizNum].infinitive)
        verbTexts.append(self.verbs[self.quizNum].completed)
        verbTexts.append(self.verbs[self.quizNum].uncompleted)
        verbTexts.append(self.verbs[self.quizNum].unstarted)
        
        return verbTexts
    }
    
    var reflections: [String]{
        var r: [String] = []
        
        r.append(Constants.verbReflections.infinitive.rawValue)
        r.append(Constants.verbReflections.completed.rawValue)
        r.append(Constants.verbReflections.uncompleted.rawValue)
        r.append(Constants.verbReflections.unstarted.rawValue)
        
        return r
    }
    
    var blankPos: Int{
        switch self.quizNum{
        case 0,4,8:
            return 0
        case 1,5,9:
            return 1
        case 2,6:
            return 2
        default:
            return 3
        }
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        let word = Word.searchOneByString(str: self.verbs[self.quizNum].infinitive)
        return DictionaryDetailViewModel(word: word)
    }
    
    init(){
        initializeVerbQuiz()
    }
}

extension VerbQuizViewModel{
    func initializeVerbQuiz(){
        self.verbs = []
        self.quizNum = 0
        self.correctNum = 0
        
        var verbsFromJson = Verb.getFromJson()
        verbsFromJson.shuffle()
        
        for i in 0..<10{
            self.verbs.append(verbsFromJson[i])
        }
        
        if RealmManager.searchQuizDataFromRealm(quizType: .verbQuiz) == nil{
            RealmManager.addNewQuizDataToRealm(quizType: .verbQuiz)
        }
    }
    
    func checkAnswer(textFieldAnswer: String) -> Bool{
        let correctAnswer: String
        switch self.blankPos{
        case 0:
            correctAnswer = self.verbs[self.quizNum].infinitive
        case 1:
            correctAnswer = self.verbs[self.quizNum].completed
        case 2:
            correctAnswer = self.verbs[self.quizNum].uncompleted
        default:
            correctAnswer = self.verbs[self.quizNum].unstarted
        }
        
        if textFieldAnswer.lowercased() == correctAnswer{
            return true
        }
        return false
    }
    
    func countUpIfCorrect(textFieldAnswer: String){
        if self.checkAnswer(textFieldAnswer: textFieldAnswer){
            self.correctNum += 1
            RealmManager.updateQuizDataInRealm(quizType: .verbQuiz, isCorrect: true)
        }else{
            RealmManager.updateQuizDataInRealm(quizType: .verbQuiz, isCorrect: false)
        }
    }
}
