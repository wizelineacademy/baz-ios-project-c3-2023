//
//  HomeMoviesCollectionViewExtension.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension HomeMoviesView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        limitControlCell = isSearching ? presenter?.getSearchedMovieCount() ?? 0: presenter?.getMovieCount() ?? 0
        foundResults = true
        
        if limitControlCell == 0 {
            limitControlCell = 1
            foundResults = false
        }

        return limitControlCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if foundResults {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.cellIdentifier, for: indexPath) as? MovieCollectionCell else {
                return UICollectionViewCell()
            }
            if let movie = self.isSearching ? self.presenter?.getSearchedMovie(indexPathRow: indexPath.row) : self.presenter?.getMovie(indexPathRow: indexPath.row){
                cell.setupCell(movie: movie)
            }

            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyMoviesCollectionCell.cellIdentifier, for: indexPath) as? EmptyMoviesCollectionCell else {
                return UICollectionViewCell()
            }
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.isSearching ? self.presenter?.getSearchedMovie(indexPathRow: indexPath.row) : self.presenter?.getMovie(indexPathRow: indexPath.row)
        self.title = ""
        self.view.addSkeletonAnimation()
        presenter?.getInformationMovie(idMovie: selectedMovie?.id ?? 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeMoviesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 60 + Constants.heightAditionalConstant)
    }
}
