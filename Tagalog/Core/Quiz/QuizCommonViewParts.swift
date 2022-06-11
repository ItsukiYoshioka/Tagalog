//
//  QuizCommonViewParts.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import SwiftUI

struct CircleCrossView: View {
    let isAnswerCorrect: Bool
    
    var body: some View {
        VStack{
            if self.isAnswerCorrect{
                Image(systemName: "circle")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: Constants.screenWidth/4, height: Constants.screenWidth/4)
                    .padding()
            }else{
                Image(systemName: "cross.fill")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: Constants.screenWidth/4, height: Constants.screenWidth/4)
                    .rotationEffect(Angle(degrees: 45))
                    .padding()
            }
            Spacer()
        }
    }
}

struct NextButton: View {
    @Binding var quizNum          : Int
    @Binding var isShowThisButton : Bool
    @Binding var isLastQuestion   : Bool
    
    var body: some View {
        Button(action: {
            if self.quizNum != 9{
                self.quizNum += 1
                self.isShowThisButton = false
            }else{
                self.isLastQuestion = true
            }
        }) {
            RoundedRectangle(cornerRadius: 20)
                .fill(self.isShowThisButton ? Color.orange : Color.white.opacity(0))
                .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/15)
                .overlay(Text(self.quizNum == 9 ? "結果へ" : "次へ")
                            .foregroundColor(Color.white)
                )
        }.disabled(!self.isShowThisButton)
            .padding()
    }
}

struct ToolbarQuizEndButton: View{
    @Binding var isQuizNow: Bool
    
    var body: some View{
        Button(action: {
            withAnimation(){
                self.isQuizNow = false
            }
        }) {
            Text("クイズを終わる")
                .font(.subheadline)
                .foregroundColor(Color.white)
        }
    }
}
