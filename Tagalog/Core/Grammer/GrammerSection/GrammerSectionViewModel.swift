//
//  GrammerSectionViewModel.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/01/17.
//

import Foundation

class GrammerSectionViewModel: ObservableObject{
    private var grammer : Grammer?
    
    @Published private var selectedContents : Contents?

    var title: String{
        self.grammer!.title
    }
    
    var sections: [String]{
        self.grammer!.contents.map{ $0.section }
    }
    
    var grammerDetailViewModel: GrammerDetailViewModel{
        GrammerDetailViewModel(title: self.title, contents: self.selectedContents)
    }
    
    init(grammer: Grammer?){
        self.grammer = grammer
    }
}

extension GrammerSectionViewModel{
    func setSelectedContents(section: String){
        self.selectedContents = self.grammer!.contents.filter{ $0.section == section }.first!
    }
}
