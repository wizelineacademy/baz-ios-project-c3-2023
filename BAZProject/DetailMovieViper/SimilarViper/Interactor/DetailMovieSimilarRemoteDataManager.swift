//
//  DetailMovieSimilarRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieSimilarRemoteDataManager: DetailMovieSimilarRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DetailMovieSimilarRemoteDataManagerOutputProtocol?
    
    private let movieApi : MovieAPI = MovieAPI()
    
    func getSimilar(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .similar(idMovie)) {
            movieApi.getMovies(for: url) { [weak self] similar in
                guard let similar = similar else {
                    self?.remoteRequestHandler?.pushNotSimilar()
                    return
                }
                self?.remoteRequestHandler?.pushSimilar(similar: similar)
            }
        }
    }
}
