//
//  ExpressionMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/18.
//

import SwiftUI

struct ExpressionMainView: View {
    @ObservedObject var viewModel    : ExpressionMainViewModel = ExpressionMainViewModel()
    @State          var isListTapped : Bool                    = false
    
    var body: some View {
        ZStack{
            List{
                ForEach(0..<self.viewModel.titles.count){ i in
                    HStack{
                        Text(self.viewModel.titles[i])
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedTitle(title: self.viewModel.titles[i])
                        self.isListTapped = true
                    }
                }
            }.listStyle(.plain)
            NavigationLink(destination: ExpressionListView(viewModel: self.viewModel.expressionListViewModel), isActive: self.$isListTapped){
                EmptyView()
            }
        }.navigationTitle("フレーズ")
    }
}
