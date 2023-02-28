//
//  DetailMovieRecommendationRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieRecommendationRemoteDataManager: DetailMovieRecommendationRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DetailMovieRecommendationRemoteDataManagerOutputProtocol?
    
    private let movieApi : MovieAPI = MovieAPI()
    
    func getRecommendation(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .recommendation(idMovie)) {
            movieApi.getMovies(for: url) { [weak self] recommendation in
                guard let recommendation = recommendation else {
                    self?.remoteRequestHandler?.pushNotRecommendation()
                    return
                }
                self?.remoteRequestHandler?.pushRecommendation(recommendation: recommendation)
            }
        }
    }
}
