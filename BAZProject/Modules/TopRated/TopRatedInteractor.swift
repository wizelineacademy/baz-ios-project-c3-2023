//
//  TopRatedInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import Foundation

class TopRatedInteractor: TopRatedInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: TopRatedInteractorOutputProtocol?
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol?
    
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
}

extension TopRatedInteractor: TopRatedRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
