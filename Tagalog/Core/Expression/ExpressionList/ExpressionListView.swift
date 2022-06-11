//
//  ExpressionListView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/18.
//

import SwiftUI

struct ExpressionListView: View {
    @ObservedObject var viewModel : ExpressionListViewModel
    @State          var pasteFlg  : Bool = false
    
    var body: some View {
        ZStack{
            List{
                ForEach(0..<self.viewModel.tagalogs.count){i in
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
                        HStack{
                            Text(self.viewModel.japaneses[i])
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical).padding(.leading)
                            if self.viewModel.isExpressionFavorites[i]{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .padding(.trailing)
                                    .onTapGesture{
                                        self.viewModel.toggleExpressionFavorite(index: i)
                                    }
                            }else{
                                Image(systemName: "star")
                                    .padding(.trailing)
                                    .onTapGesture{
                                        self.viewModel.toggleExpressionFavorite(index: i)
                                    }
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
            }.listStyle(PlainListStyle())
            if self.pasteFlg{
                CommonViewParts.PasteView(pasteFlg: self.$pasteFlg)
            }
        }.navigationTitle(self.viewModel.title)
    }
}
