//
//  JsonData.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/09.
//

import Foundation

protocol JsonData{
    associatedtype SelfType
    
    static func getFromJson() -> [SelfType]
}
