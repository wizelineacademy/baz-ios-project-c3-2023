//
//  DetailMovieSimilarRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieSimilarRemoteDataManager: DetailMovieSimilarRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DetailMovieSimilarRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getSimilar(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlSimilarMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/similar?api_key=\(apiKey)"
        movieApi.getMovies(for: urlSimilarMovie) { similar in
            guard let similar = similar else {
                return
            }
            self.remoteRequestHandler?.pushSimilar(similar: similar)
        }
    }
    
    
}
