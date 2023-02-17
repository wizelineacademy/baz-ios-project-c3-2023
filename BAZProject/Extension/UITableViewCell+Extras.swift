//
//  UITableViewCell+Extras.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}


extension UICollectionViewCell {
    class var identifier: String { return String(describing: self) }
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}
