//
//  StringExtension.swift
//  BAZProject
//
//  Created by 1014600 on 20/02/23.
//

import Foundation

extension String {
    
    /**
     A function that returns a String date

     - Returns: A String with the format EEEE, MMM d, yyyy
     */
    func getTodayDateToString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
