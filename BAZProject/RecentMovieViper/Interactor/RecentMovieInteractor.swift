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
    var recentMovies: [RecentMovie] = []

    func getMovies(idMovies: [Int]) {
        for movie in idMovies {
            group.enter()
            remoteDatamanager?.getMovie(idMovie: movie)
        }
    
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.presenter?.pushRecentMovie(recentMovie: self.recentMovies)
        }
    }
}

extension RecentMovieInteractor: RecentMovieRemoteDataManagerOutputProtocol {
    func pushRecentMovie(recentMovie: RecentMovie) {
        recentMovies.append(recentMovie)
        group.leave()
    }
}
