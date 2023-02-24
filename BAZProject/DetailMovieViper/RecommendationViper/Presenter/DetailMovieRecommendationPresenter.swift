//
//  DetailMovieRecommendationPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import UIKit

class DetailMovieRecommendationPresenter: DetailMovieRecommendationPresenterProtocol {
    
    var presenterMain: DetailMovieRecommendationProtocol?
    var interactor: DetailMovieRecommendationInteractorInputProtocol?
    var recommendation: [Movie] = []
    private let movieApi : MovieAPI = MovieAPI()
    
    /// Get the recommendation of the movie
    ///
    /// - Parameter idMovie: integer that represents the id of the movie
    func getRecommendation(idMovie: Int) {
        interactor?.getRecommendation(idMovie: idMovie)
    }
    
    /// Get the recommendation count of the movie
    ///
    /// - Returns: integer that represents the count of the recommendation
    func getRecommendationCount() -> Int {
        if recommendation.count > 5 { return 6 }
        return recommendation.count
    }
    
    /// Get the recommendation of the movie
    ///
    /// - Parameter index: integer that represents the index of the recommendation
    /// - Returns: return the recommendation object of the index
    func getRecommendation(index: Int) -> Movie {
        return recommendation[index]
    }
    
    /// Get an image from the MovieApi class using the similarImage and return and UIImage
    ///
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getRecommendationImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: recommendation[index].poster_path ?? "") { recommendationImage in
            completion(recommendationImage)
        }
    }
}

extension DetailMovieRecommendationPresenter: DetailMovieRecommendationInteractorOutputProtocol {
    func pushRecommendation(recommendation: [Movie]) {
        self.recommendation = recommendation
    }
    
    
}
