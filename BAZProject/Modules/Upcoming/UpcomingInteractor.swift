//
//  UpcomingInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class UpcomingInteractor: UpcomingInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: UpcomingInteractorOutputProtocol?
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol?
    
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
}

extension UpcomingInteractor: UpcomingRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
