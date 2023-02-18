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
    
    func getRecommendation(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlRecommendations = "https://api.themoviedb.org/3/movie/\(idMovie)/recommendations?api_key=\(apiKey)"
        movieApi.getMovies(for: urlRecommendations) { recommendation in
            guard let recommendation = recommendation else {
                return
            }
            self.remoteRequestHandler?.pushRecommendation(recommendation: recommendation)
        }
    }
    
    
}
