//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import Foundation

class TrendingInteractor: TrendingInteractorInputProtocol {
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
    

    // MARK: Properties
    weak var presenter: TrendingInteractorOutputProtocol?
    var localDatamanager: TrendingLocalDataManagerInputProtocol?
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?

}

extension TrendingInteractor: TrendingRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
