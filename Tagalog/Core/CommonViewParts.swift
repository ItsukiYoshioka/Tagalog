//
//  CommonViewParts.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/25.
//

import SwiftUI

class CommonViewParts{
    struct PasteView: View {
        @State   var pasteViewVal : Double = 10.0
        @Binding var pasteFlg     : Bool
        
        var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.2))
                    .ignoresSafeArea(.all)
            Text("クリップボードにコピーしました。")
                .padding()
                .background(Color.white)
                .overlay(Rectangle().stroke())
            }.opacity(self.pasteViewVal)
                .onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ timer in
                        self.pasteViewVal -= 0.1
                        if self.pasteViewVal == 0{
                            timer.invalidate()
                            self.pasteFlg = false
                            self.pasteViewVal = 10.0
                        }
                    }
                }
        }
    }

    struct SearchTextField: View {
        @Binding var dictionaryKind : Constants.dictionaryKind
        @Binding var searchPattern  : Constants.searchPattern
        @Binding var searchText     : String
        
        var body: some View {
            VStack{
                HStack{
                    Text("検索欄の")
                    Picker(selection: $dictionaryKind, label: Text("")){
                        Text("タガログ語").tag(Constants.dictionaryKind.tagalogToJapanese)
                        Text("日本語").tag(Constants.dictionaryKind.japaneseToTagalog)
                    }.labelsHidden()
                    Text("文字")
                    Picker(selection: $searchPattern, label: Text("")){
                        Text("で始まる").tag(Constants.searchPattern.startWith)
                        Text("を含む").tag(Constants.searchPattern.includes)
                    }.labelsHidden()
                    Text("語を検索")
                }
                HStack{
                    TextField("検索", text: self.$searchText)
                        .padding(.horizontal, 40)
                        .frame(height: 40)
                        .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                Image(systemName: "cross.circle")
                                    .rotationEffect(Angle(degrees: 45))
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing)
                                    .onTapGesture{
                                        self.searchText = ""
                                    }
                            }
                        )
                }.padding(.horizontal)
            }
        }
    }
}
