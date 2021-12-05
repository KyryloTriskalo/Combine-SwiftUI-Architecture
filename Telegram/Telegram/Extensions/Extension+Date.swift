//
//  Extension+Date.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 29.08.2021.
//

import Foundation

extension Date {
    
   func toString(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
