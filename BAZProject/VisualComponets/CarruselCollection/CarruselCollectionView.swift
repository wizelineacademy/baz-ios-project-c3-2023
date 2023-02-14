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
    
    weak var carruselDelegate: CarruselCollectionDelegate?
    
    init(delgate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        super.init(frame: .zero, collectionViewLayout: layout)

        register(CarruselCollectionViewCell.self, forCellWithReuseIdentifier: CarruselCollectionViewCell.indentifier)
        self.delegate = delgate
        self.dataSource = dataSource
    }
    
//    convenience init (delegate: CarruselCollectionDelegate) {
//        self.init(delegate: <#CarruselCollectionDelegate#>)
//        carruselDelegate = delegate
//    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


class CollectionManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarruselCollectionViewCell.indentifier,
            for: indexPath
        ) as? CarruselCollectionViewCell else {
            fatalError()
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.size.width / 3, height: self.frame.size.height)
//     }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        carruselDelegate?.didTapItem()
//    }
}
