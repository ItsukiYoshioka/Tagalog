//
//  FavoriteMainView.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/28.
//

import SwiftUI

struct FavoriteMainView: View {
    @State var isFavoriteWordActive   : Bool = false
    @State var isFavoritePhraseActive : Bool = false
    
    var body: some View {
        VStack{
            Button(action: {
                self.isFavoriteWordActive = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/2, height: Constants.screenHeight/10)
                    .overlay(Text("お気に入り単語")
                                .foregroundColor(Color.white)
                    )
            }
            Button(action: {
                self.isFavoritePhraseActive = true
            }) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.blue)
                    .frame(width: Constants.screenWidth/2, height: Constants.screenHeight/10)
                    .overlay(Text("お気に入りフレーズ")
                                .foregroundColor(Color.white)
                    )
            }
            NavigationLink(destination: FavoriteWordView(), isActive: self.$isFavoriteWordActive){
                EmptyView()
            }
            NavigationLink(destination: FavoritePhraseView(), isActive: self.$isFavoritePhraseActive){
                EmptyView()
            }
        }.navigationTitle("お気に入り")
    }
}
