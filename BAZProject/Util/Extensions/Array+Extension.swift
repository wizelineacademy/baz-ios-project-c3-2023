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

extension Array where Element: Hashable {
    func uniqued() -> Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self where !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
        return buffer
    }
}
