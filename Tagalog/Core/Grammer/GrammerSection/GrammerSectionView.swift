//
//  GrammerSectionView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/02.
//

import SwiftUI

struct GrammerSectionView: View {
    @ObservedObject var viewModel    : GrammerSectionViewModel
    @State          var isListTapped : Bool = false
    
    var body: some View {
        List{
            ForEach(0..<self.viewModel.sections.count){i in
                HStack{
                    Text(self.viewModel.sections[i])
                    Spacer()
                    Image(systemName: "chevron.right")
                }.contentShape(Rectangle())
                .onTapGesture {
                    self.viewModel.setSelectedContents(section: self.viewModel.sections[i])
                    self.isListTapped = true
                }
            }
        }.listStyle(PlainListStyle())
            .navigationTitle(self.viewModel.title)
        NavigationLink(destination: GrammerDetailView(viewModel: self.viewModel.grammerDetailViewModel), isActive: self.$isListTapped){
            EmptyView()
        }
    }
}
