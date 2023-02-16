//
//  InformationMoviesHelper.swift
//  BAZProject
//
//  Created by 1014600 on 16/02/23.
//

import UIKit

// MARK: - InformationMoviesViewProtocol
extension InformationMoviesView: InformationMoviesViewProtocol {

    /**
     Function that reloads the collectionMovieRelated and assigns his delegates.
     */
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionMovieSimilar.delegate = self
            self.collectionMovieSimilar.dataSource = self
            self.collectionMovieSimilar.reloadData()
        }
    }
    
    /**
     Function that removes the loading animation and shows an alert in case of an error ocurred in the api response.
     */
    func catchResponse(withMessage: String?) {
        DispatchQueue.main.async {
            if let message = withMessage, message != "" {
                let alert = UIAlertController(title: MovieConstants.errorAlertResult, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: MovieConstants.done, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
