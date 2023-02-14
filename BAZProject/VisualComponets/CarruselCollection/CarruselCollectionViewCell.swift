//
//  CarruselCollectionCell.swift
//  BAZProject
//
//  Created by 1034209 on 09/02/23.
//

import Foundation
import UIKit

class CarruselCollectionViewCell: UICollectionViewCell {
    static let indentifier = "CarruselCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 6
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
