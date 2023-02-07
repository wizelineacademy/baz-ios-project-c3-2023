//
//  HomeViewCategoriesCollectionExtension.swift
//  BAZProject
//
//  Created by 1050210 on 31/01/23.
//

import UIKit

// MARK: - CollectionView's DataSource

extension HomeMoviesView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesMoviesCollectionView{
            return presenter?.getCategoriesMoviesCount() ?? 0
        } else {
            return presenter?.getMoviesCount() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoriesMoviesCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesMoviesCollectionViewCell", for: indexPath) as? CategoriesMoviesCollectionViewCell
            else { return UICollectionViewCell() }
            
            presenter?.getCategorieImage(index: indexPath.row, completion: { categoryImage in
                cell.setupCategoryImage(for: categoryImage ?? nil)
            })
            cell.delegate = self
            cell.setupCell(cellTitle: presenter?.getCategorieTitle(index: indexPath.row) ?? "", indexPath: indexPath.row)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            
            presenter?.getImage(index: indexPath.row, completion: { imageMovie in
                cell.setupMovieImage(for: imageMovie ?? nil)
            })
            return cell
        }
    }
}

// MARK: - CollectionView's Delegate

extension HomeMoviesView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets,
                            left: insets,
                            bottom: insets,
                            right: insets)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemSpacing
    }
}

extension HomeMoviesView: UICollectionViewDelegateFlowLayout{
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.categoriesMoviesCollectionView{
            let cellHeight = 120.0
            let cellWidth = 200.0
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let marginsAndInsets = insets * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInterItemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            let cellHeight = itemWidth * 2.0
            let cellWidth = itemWidth * 1.0
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
