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
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        super.init(frame: .zero, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
