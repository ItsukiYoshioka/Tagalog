//
//  DateManager.swift
//  Tagalog
//
//  Created by 吉岡樹 on 2022/02/19.
//

import Foundation

class DateManager{
    class func DateToStringFmt(dt: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar   = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: dt)
    }

    class func FormatDate(dt: Date, format: String) -> Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar   = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        
        let dtString = dateFormatter.string(from: dt)
        return dateFormatter.date(from: dtString) ?? Date()
    }
}

