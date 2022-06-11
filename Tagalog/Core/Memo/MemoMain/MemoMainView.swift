//
//  MemoMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/01.
//

import SwiftUI

struct MemoMainView: View {
    @ObservedObject var viewModel            : MemoMainViewModel = MemoMainViewModel()
    @State          var isMemoAddViewActive  : Bool              = false
    @State          var isMemoEditViewActive : Bool              = false
    
    @Environment (\.editMode) var editMode

    var body: some View {
        VStack{
            List{
                ForEach(0..<self.viewModel.titles.count, id: \.self){ i in
                    VStack{
                        Text(self.viewModel.titles[i])
                            .font(.title)
                            .bold()
                            .frame(width: Constants.screenWidth, alignment: .leading)
                        Text(self.viewModel.contents[i])
                            .font(.title2)
                            .frame(width: Constants.screenWidth, alignment: .leading)
                            .padding(.bottom)
                        Text(self.viewModel.lastUpdateDate[i])
                            .frame(width: Constants.screenWidth, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedMemo(index: i)
                        self.isMemoEditViewActive = true
                    }
                }.onDelete{indexSet in
                    self.viewModel.removeMemo(atOffsets: indexSet)
                    self.viewModel.refreshMemoList()
                }
            }.listStyle(PlainListStyle())
            NavigationLink(destination: MemoAddView(isMemoAddViewActive: self.$isMemoAddViewActive), isActive: self.$isMemoAddViewActive){
                EmptyView()
            }.isDetailLink(false)
            NavigationLink(destination: MemoEditView(viewModel: self.viewModel.memoEditViewModel, isMemoEditViewActive: self.$isMemoEditViewActive), isActive: self.$isMemoEditViewActive){
                EmptyView()
            }.isDetailLink(false)
        }.navigationTitle("メモ")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    self.isMemoAddViewActive = true
                }){
                    Text("＋")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
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
        }
        .onAppear{
            self.viewModel.refreshMemoList()
        }
    }
}
