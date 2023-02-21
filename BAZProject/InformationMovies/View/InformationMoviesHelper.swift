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
     Function that reloads the collectionMovieSimilar and assigns his delegates.
     */
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionMovieSimilar.reloadData()
        }
    }
    
    /**
     Function that show an alert in case of an error ocurred in the api response.
     */
    func catchResponse(withMessage: String?) {
        DispatchQueue.main.async {
            if let message = withMessage, message != "" {
                let alert = UIAlertController(title: Constants.errorAlertResult, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.done, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loadInformationMovie(informationMovie: InformationMovie?) -> String {
        var informationMovieDisplay: String = ""
        
        if let originalTitle = informationMovie?.originalTitle{
            informationMovieDisplay += "\(originalTitle) | "
        }
        if let genres = informationMovie?.genres?.first?.name{
            informationMovieDisplay += "\(genres) | "
        }
        if let releaseDate = informationMovie?.releaseDate{
            informationMovieDisplay += "\(releaseDate) | "
        }
        if let adult = informationMovie?.adult{
            informationMovieDisplay += adult ? "18+" : "18-"
        }

        return informationMovieDisplay
    }
}
