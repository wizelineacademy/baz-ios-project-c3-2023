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
        URLBuilder.shared.idMovie = idMovie
        if let url = URLBuilder.shared.getUrl(urlType: .similar) {
            movieApi.getMovies(for: url) { similar in
                guard let similar = similar else {
                    return
                }
                self.remoteRequestHandler?.pushSimilar(similar: similar)
            }
        }
    }
    
    
}
