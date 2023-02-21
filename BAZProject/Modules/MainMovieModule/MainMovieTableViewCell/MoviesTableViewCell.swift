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
    
    weak var delegate: MoviesTableViewCellDelagete?
    var data: Movies?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionViewCell()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
    private func registerCollectionViewCell() {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
    
    private func setCollectionCell(cell: GenericCollectionViewCell, indexPath: Int) {
        UIView.fillSkeletons(onView: cell)
        if let data = data, let image = data.results[indexPath].posterPath {
            setImage(cell: cell, image: image)
        }
    }
    
    private func setImage(cell: GenericCollectionViewCell, image: String) {
        MovieAPI.getImage(from: image) { image in
            UIView.removeSkeletons(onView: cell)
            cell.imageMovie.image = image
        }
    }
}

extension MoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell{
            
            setCollectionCell(cell: cell, indexPath: indexPath.row)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data {
            return data.results.count
        }
        return 0
    }
}

extension MoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataMovies = data  {
            delegate?.didTapped(movie: dataMovies.results[indexPath.row])
        }
    }
}
