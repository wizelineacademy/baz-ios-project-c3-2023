//
//  UICarrusel.swift
//  BAZProject
//
//  Created by 1034209 on 09/02/23.
//

import Foundation
import UIKit

class CarruselCollectionView: UICollectionView {
    
    let direction: ScrollDirection
    
    init(direction: ScrollDirection) {
        self.direction = direction
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        if direction == .vertical {
            layout.minimumLineSpacing = 15
        }
        super.init(frame: .zero, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
