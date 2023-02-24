//
//  DetailMovieRecommendationRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieRecommendationRemoteDataManager: DetailMovieRecommendationRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DetailMovieRecommendationRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getRecommendation(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .recommendation(idMovie)) {
            movieApi.getMovies(for: url) { [weak self] recommendation in
                guard let recommendation = recommendation else {
                    return
                }
                self?.remoteRequestHandler?.pushRecommendation(recommendation: recommendation)
            }
        }
    }
    
    
}
