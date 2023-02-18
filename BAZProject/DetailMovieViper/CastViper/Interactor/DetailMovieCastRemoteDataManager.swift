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
        let urlCastMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/credits?api_key=\(apiKey)"
        movieApi.getCast(for: urlCastMovie) { cast in
            guard let cast = cast else { return }
            self.remoteRequestHandler?.pushCast(cast: cast)
        }
    }
    
    
}
