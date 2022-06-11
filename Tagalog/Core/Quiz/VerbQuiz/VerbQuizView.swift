//
//  VerbQuizView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/06.
//

import SwiftUI

struct VerbQuizView: View {
    @ObservedObject var viewModel       :VerbQuizViewModel = VerbQuizViewModel()
    @State          var textFieldAnswer : String           = ""
    @State          var isCheckTapped   : Bool             = false
    @State          var isLastQuestion  : Bool             = false
    @State          var goToWordDetail  : Bool             = false
    @Binding        var isVerbQuizNow   : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text(self.viewModel.japanese)
                    .font(.title2)
                    .bold()
                VStack(alignment: .leading){
                    ForEach(0..<4){i in
                        HStack{
                            Text(self.viewModel.reflections[i] + "：")
                                .font(.title3)
                            if self.viewModel.blankPos == i{
                                TextField("", text: self.$textFieldAnswer)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }else{
                                Text(self.viewModel.tagalogs[i])
                                    .font(.title3)
                            }
                        }
                    }.padding(.top).padding(.horizontal)
                }.padding()
                if !self.isCheckTapped{
                    Button(action: {
                        self.viewModel.countUpIfCorrect(textFieldAnswer: self.textFieldAnswer)
                        self.isCheckTapped = true
                    }) {
                        Text("解答する")
                            .padding()
                    }
                }else{
                    HStack{
                        Text("正解：")
                            .font(.title3)
                        Button(action: {
                            self.goToWordDetail = true
                        }){
                            Text(self.viewModel.tagalogs[self.viewModel.blankPos])
                                .foregroundColor(Color.red)
                                .font(.title3)
                                .underline()
                        }
                    }
                }
                NextButton(quizNum: self.$viewModel.quizNum, isShowThisButton: self.$isCheckTapped, isLastQuestion: self.$isLastQuestion)
                    .onTapGesture{
                        self.textFieldAnswer = ""
                    }
            }
            if self.isCheckTapped{
                CircleCrossView(isAnswerCorrect: self.viewModel.checkAnswer(textFieldAnswer: self.textFieldAnswer))
            }
            NavigationLink(destination: QuizResultView(correctNum: self.viewModel.correctNum, isQuizNow: self.$isVerbQuizNow), isActive: self.$isLastQuestion){
                EmptyView()
            }.isDetailLink(false)
        }.onDisappear{
            self.viewModel.initializeVerbQuiz()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Q" + String(self.viewModel.quizNum + 1))
        .sheet(isPresented: self.$goToWordDetail){
            DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                ToolbarQuizEndButton(isQuizNow: self.$isVerbQuizNow)
            }
        }
    }
}
