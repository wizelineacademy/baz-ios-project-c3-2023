//
//  StringExtension.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 02/02/23.
//

import Foundation

extension String {
    func convertDate(format: String, with newFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let date = formatter.date(from: self) else {
            return nil
        }
        formatter.dateFormat = newFormat
        return formatter.string(from: date)
    }
}
