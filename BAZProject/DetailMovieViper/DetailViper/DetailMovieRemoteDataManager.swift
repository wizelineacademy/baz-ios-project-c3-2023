//
//  DetailMovieRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation

class DetailMovieRemoteDataManager:DetailMovieRemoteDataManagerInputProtocol {
 
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol?
    
    private let movieApi : MovieAPI = MovieAPI()
    
    func getDetails(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .details(idMovie)) {
            movieApi.getDetails(for: url) { [weak self] detailMovie in
                guard let detailMovie = detailMovie else {
                    self?.remoteRequestHandler?.pushNotDetails()
                    return
                }
                self?.remoteRequestHandler?.pushDetailMovie(detailMovie: detailMovie)
            }
        }
    }
}
