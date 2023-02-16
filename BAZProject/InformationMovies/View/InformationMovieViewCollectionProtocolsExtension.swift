//
//  InformationMovieViewCollectionProtocolsExtension.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

// MARK: -  UICollectionViewDataSource
extension InformationMoviesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.getSimilarMoviesCount() ?? 0 > 6 {
            return 6
        }
        return presenter?.getSimilarMoviesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.cellIdentifier, for: indexPath) as? MovieCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(movie: self.presenter?.getSimilarMovie(indexPathRow: indexPath.row) ?? Movie())
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension InformationMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.presenter?.getSimilarMovie(indexPathRow: indexPath.row)
        self.title = ""
        presenter?.getInformationMovie(idMovie: selectedMovie?.id ?? 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension InformationMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 60 + MovieConstants.heightAditionalConstant)
    }
}
