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
        return MovieConstants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter?.getSimilarMoviesCount() ?? 0 > 6 {
            return 6
        }
        return presenter?.getSimilarMoviesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionSimilarCell.cellIdentifier, for: indexPath) as? MovieCollectionSimilarCell else {
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
        return MovieConstants.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MovieConstants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets : CGFloat
        marginAndInsets = MovieConstants.minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + MovieConstants.insets * CGFloat(MovieConstants.cellsPerRow - 1)
        
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(MovieConstants.cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
