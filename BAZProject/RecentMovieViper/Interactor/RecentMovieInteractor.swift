//
//  RecentMovieInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import Foundation

class RecentMovieInteractor: RecentMovieInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: RecentMovieInteractorOutputProtocol?
    var remoteDatamanager: RecentMovieRemoteDataManagerInputProtocol?
    let group = DispatchGroup()

    func getMovies(idMovies: [Int]?) {
        if let idMovies = idMovies, idMovies.count > 0 {
            for movie in idMovies {
                remoteDatamanager?.getMovie(idMovie: movie)
            }
        }
    }
}

extension RecentMovieInteractor: RecentMovieRemoteDataManagerOutputProtocol {
    func pushRecentMovie(recentMovie: RecentMovie) {
        presenter?.pushRecentMovie(recentMovie: recentMovie)
    }
}
