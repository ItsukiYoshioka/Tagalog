//
//  FavoriteWordView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/29.
//

import SwiftUI

struct FavoriteWordView: View {
    @ObservedObject var viewModel      : FavoriteWordViewModel = FavoriteWordViewModel()
    @State          var goToWordDetail : Bool                  = false
    
    @Environment (\.editMode) var editMode
    
    var body: some View {
        ZStack{
            List{
                ForEach(0..<self.viewModel.tagalogs.count, id: \.self){ i in
                    VStack{
                        Text(self.viewModel.tagalogs[i])
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text(self.viewModel.partsOfSpeeches[i])
                                .border(Color.black)
                            Text(self.viewModel.japaneses[i])
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedWord(tagalog: self.viewModel.tagalogs[i])
                        self.goToWordDetail = true
                    }
                }.onMove{(indexSet, index) in
                    self.viewModel.moveFavoriteWord(fromOffsets: indexSet, toOffset: index)
                }
                .onDelete{ indexSet in
                    self.viewModel.removeFavoriteWord(atOffsets: indexSet)
                }
            }.listStyle(PlainListStyle())
        }.navigationTitle("お気に入り単語")
        .toolbar{
            Button(action: {
                withAnimation(){
                    if editMode!.wrappedValue.isEditing{
                        editMode!.wrappedValue = .inactive
                    }else{
                        editMode!.wrappedValue = .active
                    }
                }
            }){
                if editMode!.wrappedValue.isEditing{
                    Text("終了")
                }else{
                    Text("編集")
                }
            }
        }
        .onDisappear{
            self.viewModel.reflectChangeOnDB()
        }
        .sheet(isPresented: self.$goToWordDetail){
            DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel)
        }
    }
}
