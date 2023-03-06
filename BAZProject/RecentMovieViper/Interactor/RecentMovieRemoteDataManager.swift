//
//  RecentMovieRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import Foundation

class RecentMovieRemoteDataManager:RecentMovieRemoteDataManagerInputProtocol {
   
    var remoteRequestHandler: RecentMovieRemoteDataManagerOutputProtocol?
    private let movieApi : MovieAPI = MovieAPI()
    
    func getMovie(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .details(idMovie)) {
            movieApi.getRecent(for: url) { [weak self] recentMovie in
                guard let recentMovie = recentMovie else { return }
                self?.remoteRequestHandler?.pushRecentMovie(recentMovie: recentMovie)
            }
        }
    }
}
