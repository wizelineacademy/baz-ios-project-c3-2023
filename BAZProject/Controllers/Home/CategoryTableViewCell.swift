//
//  CategoryTableViewCell.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

protocol CategoryTableCellDelegate {
    func didSelectMovie(movieId: Int, indexRow: Int)
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionToCarrucel: UICollectionView!
    
    var moviesToShow: [Movie] = []
    var categoryTableCellDelegate: CategoryTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCollectionView() {
        collectionToCarrucel.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
        setDelegates()
        setFlowLayout()
    }
    
    func setDelegates() {
        collectionToCarrucel.delegate = self
        collectionToCarrucel.dataSource = self
    }
    
    func setFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 130, height: 220)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        self.collectionToCarrucel.setCollectionViewLayout(flowLayout, animated: false)
    }
    
}

// MARK: - CollectionView's DataSource

extension CategoryTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGallery", for: indexPath) as? MovieGalleryCollectionViewCell
        collectionCell?.movieTitle.text = moviesToShow[indexPath.row].title
        collectionCell?.voteAvarage.text = moviesToShow[indexPath.row].averageStars
        if let partialURLImage =  moviesToShow[indexPath.row].posterPath {
            collectionCell?.movieImage.fetchImage(with: partialURLImage)
        } else {
            collectionCell?.movieImage.image = UIImage(named: "poster")
        }
        guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
        return collectionCell
    }
}

// MARK: - CollectionView's Delegate

extension CategoryTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryTableCellDelegate?.didSelectMovie(movieId: moviesToShow[indexPath.row].id, indexRow: indexPath.row)
    }
    
}
