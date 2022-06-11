//
//  ContentView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var isQuizViewActive: Bool = false
    
    init(){
        self.setupNavigationBar()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: DictionaryMainView()){
                        contentCell(text: "辞書")
                    }
                    NavigationLink(destination: VerbMainView()){
                        contentCell(text: "動詞の活用")
                    }
                }
                HStack{
                    NavigationLink(destination: GrammerMainView()){
                        contentCell(text: "文法")
                    }
                    NavigationLink(destination: ExpressionMainView()){
                        contentCell(text: "フレーズ")
                    }
                }
                HStack{
                    NavigationLink(destination: QuizMainView(isQuizViewActive: self.$isQuizViewActive), isActive: self.$isQuizViewActive){
                        Button(action: {
                            self.isQuizViewActive = true
                        }) {
                            contentCell(text: "クイズ")
                        }
                    }.isDetailLink(false)
                    NavigationLink(destination: FavoriteMainView()){
                        contentCell(text: "お気に入り")
                    }
                }
                HStack{
                    NavigationLink(destination: DataMainView()){
                        contentCell(text: "データ")
                    }
                    NavigationLink(destination: MemoMainView()){
                        contentCell(text: "メモ")
                    }
                }
            }.navigationTitle("メイン")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func contentCell(text: String) -> some View{
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.blue)
            .frame(width: Constants.screenWidth/2.2, height: Constants.screenHeight/6)
            .overlay(Text(text)
                        .foregroundColor(Color.white)
            )
    }
}
