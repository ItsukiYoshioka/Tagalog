//
//  WordHistoryView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/31.
//

import SwiftUI

struct WordHistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Picker(selection: self.$viewModel.ascending, label: Text("")){
                    Text("新しい順").tag(0)
                    Text("古い順").tag(1)
                }.labelsHidden()
                    .padding()
                List{
                    ForEach(0..<self.viewModel.tagalogs.count, id:\.self){ i in
                        Text(self.viewModel.tagalogs[i])
                    }
                }.listStyle(PlainListStyle())
            }
        }.navigationTitle("最近アクセスした語")
    }
}
