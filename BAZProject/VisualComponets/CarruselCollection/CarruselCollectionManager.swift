//
//  CarruselCollectionManager.swift
//  BAZProject
//
//  Created by 1034209 on 14/02/23.
//

import Foundation
import UIKit

typealias CollectionManager = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

class CarruselCollectionManager: NSObject, CollectionManager {
    
    var collection: CarruselCollectionView?
    var dataCollection: [MovieSearch]? {
        didSet {
            DispatchQueue.main.async {
                self.collection?.reloadData()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    func setupCollection(collection: CarruselCollectionView) {
        self.collection = collection
        configureCollectionViewCell(collection: collection)

    }
    
    func configureCollectionViewCell(collection: UICollectionView) {
        collection.delegate = self
        collection.dataSource = self
        collection.register(CarruselCollectionViewCell.self, forCellWithReuseIdentifier: CarruselCollectionViewCell.indentifier)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCollection?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarruselCollectionViewCell.indentifier,
            for: indexPath
        ) as? CarruselCollectionViewCell else {
            fatalError()
        }
        cell.imageView?.byURL(path: dataCollection?[indexPath.row].imageURL ?? "")
        cell.labelTitle?.text = dataCollection?[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collection = collection else {
            return .zero
        }
        
        return CGSize(width: collection.bounds.width / 3, height: collection.bounds.height * 0.9)
     }
    
}
