//
//  FavoritePhraseView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/29.
//

import SwiftUI

struct FavoritePhraseView: View {
    @ObservedObject var viewModel : FavoritePhraseViewModel = FavoritePhraseViewModel()
    @State          var pasteFlg  : Bool                    = false
    
    @Environment (\.editMode) var editMode
    
    var body: some View {
        ZStack{
            List{
                ForEach(0..<self.viewModel.tagalogs.count, id:\.self){ i in
                    VStack{
                        HStack{
                            Text(self.viewModel.tagalogs[i])
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical).padding(.leading)
                            Image(systemName: "doc.on.clipboard")
                                .padding(.trailing)
                                .onTapGesture{
                                    UIPasteboard.general.string = self.viewModel.tagalogs[i]
                                    self.pasteFlg = true
                                }
                        }.background(Color.gray.opacity(0.2))
                        Text(self.viewModel.japaneses[i])
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical).padding(.leading)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }.onMove{(indexSet, index) in
                    self.viewModel.moveFavoritePhrase(fromOffsets: indexSet, toOffset: index)
                }
                .onDelete{ indexSet in
                    self.viewModel.removeFavoritePhrase(atOffsets: indexSet)
                }
            }.listStyle(PlainListStyle())
                .navigationTitle("お気に入りフレーズ")
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
            if self.pasteFlg{
                CommonViewParts.PasteView(pasteFlg: self.$pasteFlg)
            }
        }
    }
}
