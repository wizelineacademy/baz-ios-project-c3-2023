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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToDetails(index: indexPath.row)
    }
    
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
        return 2.0
    }
}

extension HomeMoviesView: UICollectionViewDelegateFlowLayout{
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.categoriesMoviesCollectionView{
            return CGSize(width: 200, height: 120)
        } else {
            return CGSize(width: 120, height: 240)
        }
    }
}
