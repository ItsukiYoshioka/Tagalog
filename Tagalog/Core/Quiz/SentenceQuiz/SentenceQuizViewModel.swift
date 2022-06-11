//
//  SentenceQuizViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import Foundation

class SentenceQuizViewModel: ObservableObject{
    private var answerWords : [Word]                                = []
    private var answerTexts : [String]                              = []
    private var sentences   : [(tagalog: String, japanese: String)] = []
    
    var quizNum    :Int = 0
    var correctNum :Int = 0
    
    var sentenceTagalog: String{
        self.sentences[self.quizNum].tagalog
    }
    
    var sentenceJapanse: String{
        self.sentences[self.quizNum].japanese
    }
    
    var answer: String{
        self.answerTexts[self.quizNum]
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        return DictionaryDetailViewModel(word: self.answerWords[self.quizNum])
    }
    
    init(){
        self.initializeSentenceQuiz()
    }
}

extension SentenceQuizViewModel{
    func initializeSentenceQuiz(){
        self.answerWords = []
        self.answerTexts = []
        self.sentences   = []
        self.quizNum     = 0
        self.correctNum  = 0
        
        var wordsFromJson = Word.getFromJson()
        var examplesFromJson = Example.getFromJson()
        wordsFromJson.shuffle()
        examplesFromJson.shuffle()
        
        var idx = 0
        while self.answerWords.count < 10{
            let targetWord = wordsFromJson[idx]
            var pattern = targetWord.createRegexPattern()
            let examples = targetWord.searchExamplesByPattern(pattern: pattern)
            
            if !examples.isEmpty{
                pattern = pattern.replacingOccurrences(of: "[^a-z]", with: "")
                
                let regex          = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
                let matches        = regex.matches(in: examples[0].tagalog, options: [], range: NSRange(0..<examples[0].tagalog.count))
                let range          = matches[0].range(at: 0)
                let result         = (examples[0].tagalog as NSString).substring(with: range)
                let exampleTagalog = examples[0].tagalog.replacingOccurrences(of: pattern, with: " ___ ", options: [.caseInsensitive, .regularExpression])
                
                self.answerTexts.append(result)
                self.sentences.append((exampleTagalog, examples[0].japanese))
                self.answerWords.append(targetWord)
            }
            
            idx += 1
        }
        
        if RealmManager.searchQuizDataFromRealm(quizType: .sentenceQuiz) == nil{
            RealmManager.addNewQuizDataToRealm(quizType: .sentenceQuiz)
        }
    }
    
    func checkAnswer(textFieldAnswer: String) -> Bool{
        if textFieldAnswer.lowercased() == self.answerTexts[self.quizNum]{
            return true
        }
        return false
    }
    
    func countUpIfCorrect(textFieldAnswer: String){
        if checkAnswer(textFieldAnswer: textFieldAnswer){
            self.correctNum += 1
            RealmManager.updateQuizDataInRealm(quizType: .sentenceQuiz, isCorrect: true)
        }else{
            RealmManager.updateQuizDataInRealm(quizType: .sentenceQuiz, isCorrect: false)
        }
    }
}
