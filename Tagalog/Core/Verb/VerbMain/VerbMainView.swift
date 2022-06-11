//
//  VerbMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/19.
//

import SwiftUI

struct VerbMainView: View {
    @ObservedObject var viewModel      : VerbMainViewModel        = VerbMainViewModel()
    @State          var searchText     : String                   = ""
    @State          var dictionaryKind : Constants.dictionaryKind = .tagalogToJapanese
    @State          var searchPattern  : Constants.searchPattern  = .startWith
    @State          var verbTapped     : Bool                     = false
    
    var body: some View {
        let isVerbSearched = self.viewModel.searchVerbs(searchText: self.searchText, dictionaryKind: self.dictionaryKind, searchPattern: self.searchPattern)
        
        VStack{
            Divider()
            CommonViewParts.SearchTextField(dictionaryKind: self.$dictionaryKind, searchPattern: self.$searchPattern, searchText: self.$searchText)
            ZStack{
                self.searchedVerbsList()
                if self.searchText.isEmpty{
                    Text("検索欄に文字を入力してください。")
                }else if !isVerbSearched{
                    Text("検索結果がありません。")
                }
            }
            NavigationLink(destination: VerbDetailView(viewModel: self.viewModel.verbDetailViewModel), isActive: self.$verbTapped){
                EmptyView()
            }
        }.navigationTitle("動詞")
        
    }
    
    func searchedVerbsList() -> some View{
        return List{
            ForEach(0..<self.viewModel.tagalogs.count, id: \.self){ i in
                    VStack{
                        HStack{
                            Text(self.dictionaryKind == .tagalogToJapanese ? self.viewModel.tagalogs[i] : self.viewModel.japaneses[i])
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(self.viewModel.reflections[i])
                                .border(Color.black)
                        }
                        Text(self.dictionaryKind == .tagalogToJapanese ? self.viewModel.japaneses[i] : self.viewModel.tagalogs[i])
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedVerb(index: i)
                        self.verbTapped = true
                    }
            }
        }.listStyle(PlainListStyle())
    }
}
