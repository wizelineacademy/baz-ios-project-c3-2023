//
//  MovieSearchCollectionDelegate.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 17/02/23.
//

import UIKit

final class MovieSearchCollectionDelegate: NSObject {
    weak var output: MSCollectionOutputProtocol?
    
    init(output: MSCollectionOutputProtocol?) {
        self.output = output
    }
}

extension MovieSearchCollectionDelegate: MSCollectionDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output?.didSelectItem(at: indexPath)
    }
}

extension MovieSearchCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        MSMovieCollectionViewCell.sizeForRow
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        MSMovieCollectionViewCell.minimumSpace
    }
}
