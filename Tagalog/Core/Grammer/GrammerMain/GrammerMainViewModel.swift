//
//  GrammerMainViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/10.
//

import Foundation

class GrammerMainViewModel: ObservableObject{
    @Published private var selectedGrammer: Grammer?
    
    var titles: [String]{
        Grammer.getFromJson().map{ $0.title }
    }
    
    var grammerSectionViewModel: GrammerSectionViewModel{
        GrammerSectionViewModel(grammer: self.selectedGrammer)
    }
}

extension GrammerMainViewModel{
    func setSelectedGrammer(title: String){
        self.selectedGrammer = Grammer.searchOneByString(title: title)
    }
}
