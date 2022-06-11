//
//  QuizResultView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/17.
//

import SwiftUI

struct QuizResultView: View {
    let correctNum         : Int
    @Binding var isQuizNow : Bool
    
    var body: some View {
        VStack{
            Text("結果")
            Text("10問中 " + String(self.correctNum) + " 問正解")
            Button(action: {
                self.isQuizNow = false
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange)
                    .frame(width: Constants.screenWidth/3, height: Constants.screenHeight/15)
                    .overlay(Text("クイズを終わる")
                                .foregroundColor(Color.white)
                    )
            }
        }.navigationBarBackButtonHidden(true)
    }
}
