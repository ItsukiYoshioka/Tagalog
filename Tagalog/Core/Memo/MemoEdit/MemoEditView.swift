//
//  MemoEditView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/18.
//

import SwiftUI

struct MemoEditView: View {
    @ObservedObject var viewModel            : MemoEditViewModel
    @Binding        var isMemoEditViewActive : Bool
    
    var body: some View {
        VStack{
            TextField("タイトル", text: self.$viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextEditor(text: self.$viewModel.contents)
                .border(Color.gray.opacity(0.2))
                .padding()
        }.navigationTitle("新規メモ")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    self.viewModel.updateMemo()
                    self.isMemoEditViewActive = false
                }){
                    Text("保存")
                }
            }
        }
    }
}
