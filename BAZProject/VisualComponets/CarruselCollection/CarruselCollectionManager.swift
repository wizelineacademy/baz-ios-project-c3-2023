//
//  CarruselCollectionManager.swift
//  BAZProject
//
//  Created by 1034209 on 14/02/23.
//

import Foundation
import UIKit

typealias CollectionManager = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

protocol CarruselCollectionDelegate: AnyObject {
    func displayedLastItem()
    func didTap(element: CarruselCollectionItemProperties)
}

class CarruselCollectionManager<Data: CarruselCollectionItemProperties>: NSObject, CollectionManager {
    
    var collection: CarruselCollectionView?
    var carruselDelegate: CarruselCollectionDelegate?
    
    var dataCollection: [Data]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collection?.reloadData()
            }
        }
    }
    
    func setupCollection(collection: CarruselCollectionView, delegate: CarruselCollectionDelegate? = nil) {
        
        self.collection = collection
        configureCollectionViewCell(collection: collection)
        if let delegate = delegate {
            carruselDelegate = delegate
        }
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
        cell.labelTitle?.text = dataCollection?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collection = collection else {
            return .zero
        }
        if collection.direction == .vertical {
            return CGSize(width: (collection.bounds.width / 3) - 10, height: collection.bounds.height * 0.25)
        }
        
        return CGSize(width: collection.bounds.width / 3, height: collection.bounds.height)
     }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let dataCollection = dataCollection else {
            return
        }
        if collection?.direction == .vertical && (dataCollection.count - 1 == indexPath.row) {
            carruselDelegate?.displayedLastItem()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataCollection = dataCollection else {
            return
        }
        carruselDelegate?.didTap(element: dataCollection[indexPath.row])
    }
}
