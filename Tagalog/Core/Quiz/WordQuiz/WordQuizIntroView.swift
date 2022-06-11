//
//  WordQuizIntroView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/23.
//

import SwiftUI

struct WordQuizIntroView: View {
    @State var quizMaxNum: Constants.quizMaxNum = .low
    
    var body: some View {
        HStack{
            Text("設問数：")
            Picker(selection: $quizMaxNum, label: Text("")){
                Text(String(Constants.quizMaxNum.low.rawValue)).tag(Constants.quizMaxNum.low)
                Text(String(Constants.quizMaxNum.midium.rawValue)).tag(Constants.quizMaxNum.midium)
                Text(String(Constants.quizMaxNum.high.rawValue)).tag(Constants.quizMaxNum.high)
            }.labelsHidden()
            Text("問")
        }
        
    }
}
