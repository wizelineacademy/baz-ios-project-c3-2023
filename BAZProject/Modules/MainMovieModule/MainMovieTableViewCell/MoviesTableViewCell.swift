//
//  MoviesTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    static let reusableIdentifier = String(describing: MoviesTableViewCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: Codable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
}

extension MoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data as? Movies {
            DispatchQueue.main.async {
                
                if let image = data.results[indexPath.row].posterPath {
                    MovieAPI.getImage(from: image, handler: { imagen in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            cell.imageMovie.image = imagen
                        }
                    })
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data as? Movies{
            return data.results.count
        }
        return 0
    }
}
