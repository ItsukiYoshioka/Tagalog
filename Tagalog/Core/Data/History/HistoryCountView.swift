//
//  HistoryCountView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/01.
//

import SwiftUI

struct HistoryCountView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Picker(selection: self.$viewModel.ascending, label: Text("")){
                    Text("多い順").tag(0)
                    Text("少ない順").tag(1)
                }.labelsHidden()
                    .padding()
                List{
                    ForEach(0..<self.viewModel.tagalogs.count, id:\.self){ i in
                        HStack{
                            Text(self.viewModel.tagalogs[i])
                            Spacer()
                            Text(self.viewModel.counts[i])
                        }
                    }
                }.listStyle(PlainListStyle())
            }
        } .navigationTitle("語のアクセス回数")
    }
}
