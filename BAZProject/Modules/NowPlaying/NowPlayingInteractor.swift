//
//  NowPlayingInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class NowPlayingInteractor: NowPlayingInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: NowPlayingInteractorOutputProtocol?
    var remoteDatamanager: NowPlayingRemoteDataManagerInputProtocol?
    
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
}

extension NowPlayingInteractor: NowPlayingRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
