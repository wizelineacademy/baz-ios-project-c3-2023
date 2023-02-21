//
//  DetailMovieCastRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieCastRemoteDataManager: DetailMovieCastRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailMovieCastRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getCast(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        URLBuilder.shared.idMovie = idMovie
        if let url = URLBuilder.shared.getUrl(urlType: .cast) {
            movieApi.getCast(for: url) { cast in
                guard let cast = cast else { return }
                self.remoteRequestHandler?.pushCast(cast: cast)
            }
        }
    }
    
    
}
