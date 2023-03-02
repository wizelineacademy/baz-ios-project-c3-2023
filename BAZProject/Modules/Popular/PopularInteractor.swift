//
//  PopularInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class PopularInteractor: PopularInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: PopularInteractorOutputProtocol?
    var remoteDatamanager: PopularRemoteDataManagerInputProtocol?
    
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
}

extension PopularInteractor: PopularRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
