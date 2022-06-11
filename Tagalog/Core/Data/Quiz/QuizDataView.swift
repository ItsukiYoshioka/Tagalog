//
//  QuizDataView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/17.
//

import SwiftUI

struct QuizDataView: View {
    var viewModel = QuizDataViewModel()
    
    var body: some View {
        let quizTypes: [Constants.quizType] = [.wordQuiz, .sentenceQuiz, .wordOrderQuiz, .verbQuiz]
        
        ScrollView(showsIndicators: false){
            VStack{
                Text("総合")
                    .bold()
                    .font(.title2)
                    .padding()
                if self.viewModel.totalNum() != 0{
                    chart(totalNum: self.viewModel.totalNum(), correctNum: self.viewModel.correctNum())
                }
                VStack{
                    Text("回答数：" + String(self.viewModel.totalNum()))
                    Text("正解数：" + String(self.viewModel.correctNum()))
                }.padding()
                Divider()
                ForEach(0..<quizTypes.count){ i in
                    Text(quizTypes[i].rawValue)
                        .bold()
                        .font(.title2)
                        .padding()
                    if self.viewModel.totalNum(quizType: quizTypes[i]) != 0{
                        chart(totalNum: self.viewModel.totalNum(quizType: quizTypes[i]), correctNum: self.viewModel.correctNum(quizType: quizTypes[i]))
                    }
                    VStack{
                        Text("回答数：" + String(self.viewModel.totalNum(quizType: quizTypes[i])))
                        Text("正解数：" + String(self.viewModel.correctNum(quizType: quizTypes[i])))
                    }.padding()
                    Divider()
                }
            }.frame(width: Constants.screenWidth)
        }.navigationTitle("クイズデータ")
    }
    
    func chart(totalNum: Int, correctNum: Int) -> some View{
        let percentage = Double(correctNum) / Double(totalNum)
        
        return ZStack{
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(Color.red, lineWidth: 40)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: Constants.screenWidth/2, height: Constants.screenWidth/2)
            Circle()
                .trim(from: percentage, to: 1.0)
                .stroke(Color.blue, lineWidth: 40)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: Constants.screenWidth/2, height: Constants.screenWidth/2)
            VStack{
                Text("正答率")
                Text(String(round(percentage*100*10)/10) + "%")
            }
        }.padding()
    }
}
