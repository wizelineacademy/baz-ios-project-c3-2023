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
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfSimiliarMovies = presenter?.getSimilarMoviesCount() else { return 0 }
        return numberOfSimiliarMovies > 6 ? 6 : numberOfSimiliarMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleatedMovieCollectionCell.cellIdentifier, for: indexPath) as? ReleatedMovieCollectionCell else {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets : CGFloat
        marginAndInsets = Constants.minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + Constants.insets * CGFloat(Constants.cellsPerRow - 1)
        
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(Constants.cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
