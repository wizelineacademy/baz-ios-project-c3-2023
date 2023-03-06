//
//  DetailMovieCastRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieCastRemoteDataManager: DetailMovieCastRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailMovieCastRemoteDataManagerOutputProtocol?
    
    private let movieApi : MovieAPI = MovieAPI()
    
    func getCast(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .cast(idMovie)) {
            movieApi.getCast(for: url) { [weak self] cast in
                guard let cast = cast else {
                    self?.remoteRequestHandler?.pushNotCast()
                    return
                }
                self?.remoteRequestHandler?.pushCast(cast: cast)
            }
        }
    }
    
    
}
