//
//  GrammerDetailView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/17.
//

import SwiftUI

struct GrammerDetailView: View {
    @ObservedObject var viewModel : GrammerDetailViewModel
    @State          var pasteFlg  : Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Text(self.viewModel.section)
                    .font(.title2)
                    .bold()
                    .padding(.top)
                Divider()
                Text(self.viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
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
                                if self.viewModel.isExampleFavorites[i]{
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                        .padding(.trailing)
                                        .onTapGesture{
                                            self.viewModel.toggleExampleFavorite(index: i)
                                        }
                                }else{
                                    Image(systemName: "star")
                                        .padding(.trailing)
                                        .onTapGesture{
                                            self.viewModel.toggleExampleFavorite(index: i)
                                        }
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.listStyle(PlainListStyle())
            }
            if self.pasteFlg{
                CommonViewParts.PasteView(pasteFlg: self.$pasteFlg)
            }
        }.navigationTitle(self.viewModel.title)
    }
}
