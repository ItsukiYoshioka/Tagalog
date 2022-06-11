//
//  VerbDetailView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/19.
//

import SwiftUI

struct VerbDetailView: View {
    var viewModel             : VerbDetailViewModel
    @State var pasteFlg       : Bool = false
    @State var goToWordDetail : Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text(self.viewModel.reflectedVerbs[1])
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Image(systemName: "doc.on.clipboard")
                        .onTapGesture{
                            UIPasteboard.general.string = self.viewModel.reflectedVerbs[1]
                            self.pasteFlg = true
                        }
                }
                Divider()
                Text(self.viewModel.japanese)
                    .font(.title3)
                    .padding()
                Text(self.viewModel.type + " 動詞, " + self.viewModel.focus)
                List{
                    ForEach(0..<self.viewModel.reflectedVerbs.count, id:\.self){ i in
                        VStack{
                            HStack{
                                Text(self.viewModel.reflections[i])
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 6).padding(.leading)
                            }.background(Color.gray.opacity(0.2))
                            HStack{
                                Text(self.viewModel.reflectedVerbs[i])
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 6).padding(.leading)
                                Image(systemName: "doc.on.clipboard")
                                    .padding(.trailing)
                                    .onTapGesture{
                                        UIPasteboard.general.string = self.viewModel.reflectedVerbs[i]
                                        self.pasteFlg = true
                                    }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.listStyle(PlainListStyle())
            }
            if self.pasteFlg{
                CommonViewParts.PasteView(pasteFlg: self.$pasteFlg)
            }
            NavigationLink(destination: DictionaryDetailView(viewModel: self.viewModel.dictionaryDetailViewModel), isActive: self.$goToWordDetail){
                EmptyView()
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.goToWordDetail = true
                }){
                    Text("例文へ＞")
                }
            }
        }
    }
}
