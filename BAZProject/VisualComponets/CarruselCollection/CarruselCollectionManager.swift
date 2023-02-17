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
    
    let collection: CarruselCollectionView
    var dataCollection: [Home.FetchMoviesBySection.ViewModel.Movie]? {
        didSet {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
    
    init(collection: CarruselCollectionView) {
        self.collection = collection
        super.init()
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
        return CGSize(width: collection.bounds.width / 3, height: collection.bounds.height * 0.9)
     }
    
}
