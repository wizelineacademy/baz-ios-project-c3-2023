//
//  UITableViewCell+Extras.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

extension UITableViewCell {
    static var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}


extension UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}
