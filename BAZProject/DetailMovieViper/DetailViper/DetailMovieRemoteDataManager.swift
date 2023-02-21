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
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getDetails(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        URLBuilder.shared.idMovie = idMovie
        if let url = URLBuilder.shared.getUrl(urlType: .details){
            movieApi.getDetails(for: url) { detailMovie in
                guard let detailMovie = detailMovie else { return }
                self.remoteRequestHandler?.pushDetailMovie(detailMovie: detailMovie)
            }
        }
    }
}
