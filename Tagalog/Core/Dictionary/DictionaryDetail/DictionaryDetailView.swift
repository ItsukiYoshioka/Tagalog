//
//  DictionaryDetailView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/24.
//

import SwiftUI

struct DictionaryDetailView: View {
    @ObservedObject var viewModel: DictionaryDetailViewModel
    @State          var pasteFlg : Bool = false
    
    var body: some View {
        if self.viewModel.isWordNil{
            Text("対象となる語が辞書にありませんでした。")
        }else{
            ZStack{
                VStack{
                    HStack{
                        Text(self.viewModel.wordTagalog)
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        Image(systemName: "doc.on.clipboard")
                            .onTapGesture{
                                UIPasteboard.general.string = self.viewModel.wordTagalog
                                self.pasteFlg = true
                            }
                    }
                    Divider()
                    HStack{
                        Text(self.viewModel.wordPartsOfSpeech)
                            .font(.title3)
                            .border(Color.black)
                        Text(self.viewModel.wordJapanese)
                            .font(.title3)
                            .padding()
                    }
                    ForEach(0..<self.viewModel.sameWordJapaneses.count, id: \.self){i in
                        HStack{
                            Text(self.viewModel.sameWordPartsOfSpeeches[i])
                                .font(.title3)
                                .border(Color.black)
                                .padding(.leading)
                            Text(self.viewModel.sameWordJapaneses[i])
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    DictionaryPhraseList(viewModel: self.viewModel, pasteFlg: self.$pasteFlg)
                }
                if self.pasteFlg{
                    CommonViewParts.PasteView(pasteFlg: self.$pasteFlg)
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    if self.viewModel.isWordFavorite{
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                            .onTapGesture{
                                self.viewModel.toggleWordFavorite()
                            }
                    }else{
                        Image(systemName: "star")
                            .onTapGesture{
                                self.viewModel.toggleWordFavorite()
                            }
                    }
                }
            }.onAppear{
                self.viewModel.updateWordHistory()
            }
        }
    }
    
    struct DictionaryPhraseList: View {
        @ObservedObject var viewModel: DictionaryDetailViewModel
        @Binding var pasteFlg: Bool
        
        var body: some View {
            List{
                ForEach(0..<self.viewModel.exampleTagalogs.count, id: \.self){ i in
                    VStack{
                        HStack{
                            Text(self.viewModel.exampleTagalogs[i])
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical).padding(.leading)
                            Image(systemName: "doc.on.clipboard")
                                .padding(.trailing)
                                .onTapGesture{
                                    UIPasteboard.general.string = self.viewModel.exampleTagalogs[i]
                                    self.pasteFlg = true
                                }
                        }.background(Color.gray.opacity(0.2))
                        HStack{
                            Text(self.viewModel.exampleJapaneses[i])
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
    }
}

