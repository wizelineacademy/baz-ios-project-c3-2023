//
//  ViewExtension.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

extension UIView {
    func makeRound(divide: CGFloat) {
        self.layer.cornerRadius = self.frame.size.width/divide
        self.clipsToBounds = true
    }
}
