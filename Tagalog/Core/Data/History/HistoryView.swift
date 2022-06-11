//
//  HistoryView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/16.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel : HistoryViewModel = HistoryViewModel()
    @State          var reset     : Bool             = false
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color.gray.opacity(0.2))
    }
    
    var body: some View {
        TabView(selection: self.$viewModel.viewType){
            WordHistoryView(viewModel: self.viewModel)
                .tabItem{
                    Image(systemName: "123.rectangle")
                    Text("最近アクセスした語")
                }
                .tag(Constants.historyViewType.wordHistory)
            HistoryCountView(viewModel: self.viewModel)
                .tabItem{
                    Image(systemName: "123.rectangle.fill")
                    Text("語のアクセス回数")
                }
                .tag(Constants.historyViewType.historyCount)
        }.alert(isPresented: self.$reset){
            Alert(title: Text("履歴のリセット"), message: Text("リセットしてよろしいですか？"), primaryButton: .cancel(Text("いいえ")), secondaryButton: .destructive(Text("はい"), action: { self.viewModel.resetHistory()}))
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    self.reset = true
                }){
                    Text("リセット")
                }
            }
        }
    }
}
