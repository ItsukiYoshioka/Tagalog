//
//  QuizMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/16.
//

import SwiftUI

struct QuizMainView: View {
    @State   var isWordQuizNow      : Bool = false
    @State   var isSentenceQuizNow  : Bool = false
    @State   var isWordOrderQuizNow : Bool = false
    @State   var isVerbQuizNow      : Bool = false
    @Binding var isQuizViewActive   : Bool
    
    var body: some View {
        VStack{
            Button(action: {
                self.isWordQuizNow = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/10)
                    .overlay(Text(Constants.quizType.wordQuiz.rawValue)
                                .foregroundColor(Color.white)
                    )
            }
            Button(action: {
                self.isSentenceQuizNow = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/10)
                    .overlay(Text(Constants.quizType.sentenceQuiz.rawValue)
                                .foregroundColor(Color.white)
                    )
            }
            Button(action: {
                self.isWordOrderQuizNow = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/10)
                    .overlay(Text(Constants.quizType.wordOrderQuiz.rawValue)
                                .foregroundColor(Color.white)
                    )
            }
            Button(action: {
                self.isVerbQuizNow = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/10)
                    .overlay(Text(Constants.quizType.verbQuiz.rawValue)
                                .foregroundColor(Color.white)
                    )
            }
            NavigationLink(destination: WordQuizView(isWordQuizNow: self.$isWordQuizNow), isActive: self.$isWordQuizNow){
                EmptyView()
            }.isDetailLink(false)
            NavigationLink(destination: SentenceQuizView(isSentenceQuizNow: self.$isSentenceQuizNow), isActive: self.$isSentenceQuizNow){
                EmptyView()
            }.isDetailLink(false)
            NavigationLink(destination: WordOrderQuizView(isWordOrderQuizNow: self.$isWordOrderQuizNow), isActive: self.$isWordOrderQuizNow){
                EmptyView()
            }.isDetailLink(false)
            NavigationLink(destination: VerbQuizView(isVerbQuizNow: self.$isVerbQuizNow), isActive: self.$isVerbQuizNow){
                EmptyView()
            }.isDetailLink(false)
        }.navigationBarBackButtonHidden(true)
            .navigationTitle("クイズ")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {withAnimation(){self.isQuizViewActive = false}}) {Text("メイン画面へ").font(.subheadline).foregroundColor(Color.white)}
                }
            }
    }
}
