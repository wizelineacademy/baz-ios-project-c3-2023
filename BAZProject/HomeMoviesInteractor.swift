//
//  HomeMoviesInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation

class HomeMoviesInteractor: HomeMoviesInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: HomeMoviesInteractorOutputProtocol?
    var localDatamanager: HomeMoviesLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeMoviesRemoteDataManagerInputProtocol?

    func getTrendingMovies() {
        remoteDatamanager?.getTrendingMovies()
    }
}

extension HomeMoviesInteractor: HomeMoviesRemoteDataManagerOutputProtocol {
  
    // TODO: Implement use case methods
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        presenter?.pushTrendingMovieInfo(trendingMovies: trendingMovies)
    }
    
}
