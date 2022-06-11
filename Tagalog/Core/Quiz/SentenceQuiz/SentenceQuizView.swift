//
//  SentenceQuizView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/26.
//

import SwiftUI

struct SentenceQuizView: View {
    @ObservedObject var viewModel         : SentenceQuizViewModel = SentenceQuizViewModel()
    @State          var isCheckTapped     : Bool                  = false
    @State          var textFieldAnswer   : String                = ""
    @State          var isLastQuestion    : Bool                  = false
    @State          var goToWordDetail    : Bool                  = false
    @Binding        var isSentenceQuizNow : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text(self.viewModel.sentenceJapanse)
                    .font(.title)
                Text(self.viewModel.sentenceTagalog)
                    .font(.title2)
                    .padding()
                if !self.isCheckTapped{
                    TextField("解答入力", text: self.$textFieldAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal).padding(.top)
                    Button(action: {
                        self.viewModel.countUpIfCorrect(textFieldAnswer: self.textFieldAnswer)
                        self.isCheckTapped = true
                    }) {
                        Text("解答する")
                            .padding()
                            .onAppear(){
                                self.textFieldAnswer = ""
                            }
                    }
                }else{
                    HStack{
                        Text("解答：")
                            .font(.title3)
                            .padding(.top)
                        Text(self.textFieldAnswer)
                            .font(.title3)
                            .padding(.top)
                    }
                    HStack{
                        Text("正解：")
                            .font(.title3)
                        Button(action: {
                            self.goToWordDetail = true
                        }){
                            Text(self.viewModel.answer)
                                .foregroundColor(Color.red)
                                .font(.title3)
                                .underline()
                        }
                    }
                }
                NextButton(quizNum: self.$viewModel.quizNum, isShowThisButton: self.$isCheckTapped, isLastQuestion: self.$isLastQuestion)
            }
            if self.isCheckTapped{
                CircleCrossView(isAnswerCorrect: self.viewModel.checkAnswer(textFieldAnswer: self.textFieldAnswer))
            }
            NavigationLink(destination: QuizResultView(correctNum: self.viewModel.correctNum, isQuizNow: self.$isSentenceQuizNow), isActive: self.$isLastQuestion){
                EmptyView()
            }.isDetailLink(false)
        }.onDisappear{
            self.viewModel.initializeSentenceQuiz()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Q" + String(self.viewModel.quizNum + 1))
        .sheet(isPresented: self.$goToWordDetail){
            DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                ToolbarQuizEndButton(isQuizNow: self.$isSentenceQuizNow)
            }
        }
    }
}
