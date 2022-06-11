//
//  MemoAddView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/18.
//

import SwiftUI

struct MemoAddView: View {
    var viewModel = MemoAddViewModel()
    
    @State   var title               : String = ""
    @State   var contents            : String = ""
    @Binding var isMemoAddViewActive : Bool
    
    var body: some View {
        VStack{
            TextField("タイトル", text: self.$title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextEditor(text: self.$contents)
                .border(Color.gray.opacity(0.2))
                .padding()
        }.navigationTitle("新規メモ")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    self.viewModel.storeMemo(title: self.title, contents: self.contents)
                    self.isMemoAddViewActive = false
                }){
                    Text("保存")
                }
            }
        }
    }
}
