//
//  ShowMoviesTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

final class ShowMoviesTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: ShowMoviesTableViewCell.self)
    var data: Movies?
    weak var delegate: MovieDetailPresenter?
    let imageProvider = ImageProvider.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
    
}

extension ShowMoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data {
            return data.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data {
            cell.imageMovie.image = UIImage(named: "poster")
            UIView.fillSkeletons(onView: cell)
            
            if let image = data.results[indexPath.row].posterPath {
                imageProvider.fetchImage(from: image, completion: { image in
                        UIView.removeSkeletons(onView: cell)
                        cell.imageMovie.image = image
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ShowMoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = data?.results[indexPath.row] {
            delegate?.goToMovieDetail(data: data)
        }
    }
}
