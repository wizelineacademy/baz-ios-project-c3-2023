//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 21/02/23.
//

import Foundation

class MovieDetailInteractor {
    var presenter: MovieDetailInteractorOutputProtocol?
    
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    func fetchMovieDetail(of movieId: Int?) {
        if let movieId = movieId {
            self.remoteDatamanager?.fetchMovieDetail(of: movieId)
        }
    }
    
    func notifyMovieDetailShown() {
        let notificationName = Notification.Name("movieDetailShown")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    func movieDetailFetched(with movieDetail: MovieDetail) {
        self.presenter?.movieDetailFetched(with: movieDetail)
    }
}
