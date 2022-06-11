//
//  DataMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/31.
//

import SwiftUI

struct DataMainView: View {
    @State var isHistoryViewActive  : Bool = false
    @State var isQuizDataViewActive : Bool = false
    
    var body: some View {
        ZStack{
            List{
                HStack{
                    Text("単語アクセス履歴")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.contentShape(Rectangle())
                .onTapGesture {
                    self.isHistoryViewActive = true
                }
                HStack{
                    Text("クイズデータ")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.contentShape(Rectangle())
                .onTapGesture {
                    self.isQuizDataViewActive = true
                }
            }.listStyle(.plain)
            NavigationLink(destination: HistoryView(), isActive: self.$isHistoryViewActive){
                EmptyView()
            }
            NavigationLink(destination: QuizDataView(), isActive: self.$isQuizDataViewActive){
                EmptyView()
            }
        }.navigationTitle("データ")
    }
}
