//
//  DataReformatter.swift
//  Test1
//
//  Created by Данила Бердников on 29.08.2022.
//

import Foundation

extension String {
    
    func reFormat(from dateStr: String) -> String? {
      let fromFormatter = DateFormatter()
      fromFormatter.dateFormat = "yyyy-MM-dd"

      let toFormatter = DateFormatter()
        toFormatter.locale = Locale(identifier: "en_US_POSIX")
      toFormatter.dateFormat = "MMM d, yyyy"

        
        
        
        
      guard let date = fromFormatter.date(from: dateStr) else { return nil }

      return toFormatter.string(from: date)
    }
}
