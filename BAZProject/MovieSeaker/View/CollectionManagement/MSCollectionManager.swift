//
//  MSCollectionManager.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

//MARK: - Data source management
extension MovieSeakerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MSMovieCollectionViewCell.identifier,
            for: indexPath
        )
        if let movieCell = cell as? MSMovieCollectionViewCell {
            let movie = movies[indexPath.row]
            movieCell.setupCell(with: movie)
        }
        return cell
    }
}

//MARK: - Collection view layout management
extension MovieSeakerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        MSMovieCollectionViewCell.sizeForRow
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        MSMovieCollectionViewCell.minimumSpace
    }
}

//MARK: - UICollectionViewDelegate
extension MovieSeakerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.output?.didSelect(movie)
    }
}
