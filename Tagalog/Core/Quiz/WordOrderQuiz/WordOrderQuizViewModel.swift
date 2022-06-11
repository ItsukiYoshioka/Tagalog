//
//  WordOrderQuizViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import Foundation

class WordOrderQuizViewModel: ObservableObject{
    private var examples            : [Example]  = []
    private var _selections         : [[String]] = []
    private var answerAreaSentences : [String]   = []
    
    var selectedSelection : Int = 0
    var quizNum           : Int = 0
    var correctNum        : Int = 0
    
    var sentenceJapanese: String{
        self.examples[self.quizNum].japanese
    }
    
    var answerAreaSentence: String{
        self.answerAreaSentences[self.quizNum]
    }
    
    var selections: [String]{
        self._selections[self.quizNum]
    }
    
    var answer: String{
        self.examples[self.quizNum].tagalog
    }
    
    var dictionaryDetailViewModel: DictionaryDetailViewModel{
        let word = Word.searchOneByString(str: self._selections[self.quizNum][selectedSelection])
        return DictionaryDetailViewModel(word: word)
    }
    
    init(){
        initializeWordOrderQuiz()
    }
}

extension WordOrderQuizViewModel{
    func initializeWordOrderQuiz(){
        self.examples            = []
        self._selections         = []
        self.answerAreaSentences = []
        self.quizNum             = 0
        self.correctNum          = 0
        
        let exampleFromJson = Example.getFromJson()
        
        for k in 0..<10{
            let i = Int.random(in: 0..<exampleFromJson.count)
            self.examples.append(exampleFromJson[i])
            self.answerAreaSentences.append(makeUnscoSentence(tagalogSentence: exampleFromJson[i].tagalog))
            self.setSelections(num: k)
        }
        
        if RealmManager.searchQuizDataFromRealm(quizType: .wordOrderQuiz) == nil{
            RealmManager.addNewQuizDataToRealm(quizType: .wordOrderQuiz)
        }
    }
    
    private func setSelections(num: Int){
        var selections = self.examples[num].tagalog.components(separatedBy: " ")
        let deleteLetters: Set<Character> = [",", ".", "!", "?"]
        for i in 0..<selections.count{
            selections[i].removeAll(where: { deleteLetters.contains($0) })
        }
        selections[0] = selections[0].lowercased()
        selections.shuffle()
        self._selections.append(selections)
    }
    
    private func makeUnscoSentence(tagalogSentence: String) -> String{
        let unscoSentence = String(repeating: "_", count: tagalogSentence.count)
        return unscoSentence + tagalogSentence.suffix(1)
    }
    
    func resetAnswerAreaSentence(){
        self.answerAreaSentences[self.quizNum] = makeUnscoSentence(tagalogSentence: self.examples[self.quizNum].tagalog)
    }
    
    func refreshAnswerAreaSentence(selection: String){
        var s = selection
        let sentence = self.answerAreaSentence
        let replaceFrom = sentence.index(sentence.firstIndex(of: "_")!, offsetBy: 0)
        let replaceTo = sentence.index(replaceFrom, offsetBy: selection.count + 1)
        
        if replaceFrom == sentence.startIndex{
            let firstLetterUpper = s.prefix(1).uppercased()
            let restLetters = s.dropFirst()
            s = firstLetterUpper + restLetters
        }
        
        self.answerAreaSentences[self.quizNum].replaceSubrange(replaceFrom..<replaceTo, with: s + " ")
    }
    
    func checkAnswer() -> Bool{
        let deleteLetter: Set<Character> = [" "]
        var answer = self.answerAreaSentence
        var correctSentence = self.examples[self.quizNum].tagalog
        
        answer.removeAll(where: { deleteLetter.contains($0) })
        correctSentence.removeAll(where: { deleteLetter.contains($0) })
        
        if answer == correctSentence{
            return true
        }
        return false
    }
    
    func countUpIfCorrect(){
        if self.checkAnswer(){
            self.correctNum += 1
            RealmManager.updateQuizDataInRealm(quizType: .wordOrderQuiz, isCorrect: true)
        }else{
            RealmManager.updateQuizDataInRealm(quizType: .sentenceQuiz, isCorrect: false)
        }
    }
}
