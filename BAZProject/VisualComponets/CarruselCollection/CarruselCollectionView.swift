//
//  UICarrusel.swift
//  BAZProject
//
//  Created by 1034209 on 09/02/23.
//

import Foundation
import UIKit

protocol CarruselCollectionDelegate: AnyObject {
    func didTapItem()
}

class CarruselCollectionView: UICollectionView {
    init(direction: ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        super.init(frame: .zero, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
