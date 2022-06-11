//
//  WordQuizView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/16.
//

import SwiftUI
import RealmSwift

struct WordQuizView: View {
    @ObservedObject var viewModel       : WordQuizViewModel = WordQuizViewModel()
    @State          var isChoiceTapped  : Bool              = false
    @State          var chosenButtonNum : Int               = 0
    @State          var isLastQuestion  : Bool              = false
    @State          var goToWordDetail  : Bool              = false
    @Binding        var isWordQuizNow   : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text(self.viewModel.question)
                    .font(.title)
                    .padding()
                VStack{
                    ForEach(0..<2){ i in
                        HStack{
                            ForEach(0..<2){ k in
                                self.choiceButton(buttonNum: i*2+k)
                            }
                        }
                    }
                }.padding()
                NextButton(quizNum: self.$viewModel.quizNum, isShowThisButton: self.$isChoiceTapped, isLastQuestion: self.$isLastQuestion)
            }
            if self.isChoiceTapped{
                CircleCrossView(isAnswerCorrect: self.viewModel.checkAnswer(buttonNum: self.chosenButtonNum))
            }
            NavigationLink(destination: QuizResultView(correctNum: self.viewModel.correctNum, isQuizNow: self.$isWordQuizNow), isActive: self.$isLastQuestion){
                EmptyView()
            }.isDetailLink(false)
        }.onDisappear{
            self.viewModel.initializeWordQuiz()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Q" + String(self.viewModel.quizNum + 1))
        .sheet(isPresented: self.$goToWordDetail){
            DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                ToolbarQuizEndButton(isQuizNow: self.$isWordQuizNow)
            }
        }
    }
    
    func choiceButton(buttonNum: Int) -> some View{
        let quizChoice = self.viewModel.quizChoices[buttonNum]
        
        return Button(action: {
            if self.isChoiceTapped{
                self.viewModel.selectedChoiceIndex = buttonNum
                self.goToWordDetail = true
            }else{
                self.chosenButtonNum = buttonNum
                self.viewModel.countUpIfCorrect(buttonNum: self.chosenButtonNum)
                self.isChoiceTapped = true
            }
        }) {
            if self.isChoiceTapped && self.viewModel.checkAnswer(buttonNum: buttonNum){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red)
                    .frame(width: Constants.screenWidth/2.2, height: Constants.screenHeight/10)
                    .overlay(Text(quizChoice)
                                .foregroundColor(Color.white)
                    )
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .fill(self.isChoiceTapped && self.chosenButtonNum == buttonNum ? Color.orange : Color.blue)
                    .frame(width: Constants.screenWidth/2.2, height: Constants.screenHeight/10)
                    .overlay(Text(quizChoice)
                                .foregroundColor(Color.white)
                    )
            }
        }
    }
}

