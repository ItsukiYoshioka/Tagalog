//
//  GrammerMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/17.
//

import SwiftUI

struct GrammerMainView: View {
    @ObservedObject var viewModel    : GrammerMainViewModel = GrammerMainViewModel()
    @State          var isListTapped : Bool                 = false
    
    var body: some View {
        VStack{
            List{
                ForEach(0..<self.viewModel.titles.count){i in
                    HStack{
                        Text(self.viewModel.titles[i])
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.setSelectedGrammer(title: self.viewModel.titles[i])
                        self.isListTapped = true
                    }
                }
            }.listStyle(PlainListStyle())
            NavigationLink(destination: GrammerSectionView(viewModel: self.viewModel.grammerSectionViewModel), isActive: self.$isListTapped){
                EmptyView()
            }
        }.navigationTitle("文法")
    }
}

