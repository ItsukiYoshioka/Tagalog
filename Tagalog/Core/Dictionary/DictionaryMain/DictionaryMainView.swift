//
//  DictionaryMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/14.
//

import SwiftUI

struct DictionaryMainView: View {
    @ObservedObject var viewModel      : DictionaryMainViewModel  = DictionaryMainViewModel()
    @State          var searchText     : String                   = ""
    @State          var dictionaryKind : Constants.dictionaryKind = .tagalogToJapanese
    @State          var searchPattern  : Constants.searchPattern  = .startWith
    @State          var wordTapped     : Bool                     = false
    
    var body: some View {
        let isWordSearched = self.viewModel.searchWords(searchText: self.searchText, dictionaryKind: self.dictionaryKind, searchPattern: self.searchPattern)
        
        VStack{
            Divider()
            CommonViewParts.SearchTextField(dictionaryKind: self.$dictionaryKind, searchPattern: self.$searchPattern, searchText: self.$searchText)
            ZStack{
                self.searchedWordsList()
                if searchText.isEmpty{
                    Text("検索欄に文字を入力してください。")
                }else if !isWordSearched{
                    Text("検索結果がありません。")
                }
            }
            NavigationLink(destination: DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel), isActive: self.$wordTapped){
                EmptyView()
            }
        }.navigationTitle("辞書")
    }
    
    func searchedWordsList() -> some View{
        return List{
            ForEach(0..<self.viewModel.tagalogs.count, id: \.self){ i in
                    VStack{
                        Text(self.dictionaryKind == .tagalogToJapanese ? self.viewModel.tagalogs[i] : self.viewModel.japaneses[i])
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text(self.viewModel.partsOfSpeeches[i])
                                .border(Color.black)
                            Text(self.dictionaryKind == .tagalogToJapanese ? self.viewModel.japaneses[i] : self.viewModel.tagalogs[i])
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedWord(index: i)
                        self.wordTapped = true
                    }
                }
            }.listStyle(PlainListStyle())
    }
}
