//
//  WordOrderQuizView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/05.
//

import SwiftUI

struct WordOrderQuizView: View {
    @ObservedObject var viewModel          : WordOrderQuizViewModel = WordOrderQuizViewModel()
    @State          var isCheckTapped      : Bool              = false
    @State          var isLastQuestion     : Bool              = false
    @State          var goToWordDetail     : Bool              = false
    @State          var chosenSelections   : [Int]             = []
    @Binding        var isWordOrderQuizNow : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text(self.viewModel.sentenceJapanese)
                    .font(.title2)
                    .padding(.vertical)
                Text(self.viewModel.answerAreaSentence)
                    .font(.title2)
                    .padding()
                if self.isCheckTapped{
                    VStack{
                        Text(self.viewModel.answer)
                            .font(.title2)
                            .foregroundColor(Color.red)
                            .padding(.horizontal)
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)){
                    ForEach(0..<self.viewModel.selections.count, id: \.self){ i in
                        selectionButton(buttonNum: i, selection: self.viewModel.selections[i])
                    }
                }
                if !self.isCheckTapped{
                    HStack{
                        Button(action: {
                            self.viewModel.resetAnswerAreaSentence()
                            self.chosenSelections.removeAll()
                        }){
                            Text("リセット")
                                .padding()
                        }
                        Button(action: {
                            self.viewModel.countUpIfCorrect()
                            self.isCheckTapped = true
                        }) {
                            Text("解答する")
                                .padding()
                                .onAppear(){
                                    self.chosenSelections.removeAll()
                                }
                        }
                    }
                }
                NextButton(quizNum: self.$viewModel.quizNum, isShowThisButton: self.$isCheckTapped, isLastQuestion: self.$isLastQuestion)
            }
            if self.isCheckTapped{
                CircleCrossView(isAnswerCorrect: self.viewModel.checkAnswer())
            }
            NavigationLink(destination: QuizResultView(correctNum: self.viewModel.correctNum, isQuizNow: self.$isWordOrderQuizNow), isActive: self.$isLastQuestion){
                EmptyView()
            }.isDetailLink(false)
        }.onDisappear{
            self.viewModel.initializeWordOrderQuiz()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Q" + String(self.viewModel.quizNum + 1))
        .sheet(isPresented: self.$goToWordDetail){
            DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                ToolbarQuizEndButton(isQuizNow: self.$isWordOrderQuizNow)
            }
        }
    }
    
    func selectionButton(buttonNum: Int, selection: String) -> some View{
        Button(action: {
            if !self.isCheckTapped{
                self.viewModel.refreshAnswerAreaSentence(selection: selection)
                if let idx = self.chosenSelections.firstIndex(of: buttonNum){
                    self.chosenSelections.remove(at: idx)
                }else{
                    self.chosenSelections.append(buttonNum)
                }
            }else{
                self.viewModel.selectedSelection = buttonNum
                self.goToWordDetail = true
            }
        }) {
            RoundedRectangle(cornerRadius: 20)
                .fill(self.chosenSelections.contains(buttonNum) ? Color.gray : Color.blue)
                .frame(width: Constants.screenWidth/2.2, height: Constants.screenHeight/20)
                .overlay(Text(selection)
                            .foregroundColor(Color.white)
                )
        }.disabled(!self.isCheckTapped && self.chosenSelections.contains(buttonNum))
    }
}
