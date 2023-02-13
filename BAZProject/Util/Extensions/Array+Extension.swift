//
//  Array+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 13/02/23.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index < count && index >= 0) ? self[index] : nil
    }
}
