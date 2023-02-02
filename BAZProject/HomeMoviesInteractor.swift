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
    
    func getNowPlayingMovies() {
        remoteDatamanager?.getNowPlayingMovies()
    }
    
    func getPopularMovies() {
        remoteDatamanager?.getPopularMovies()
    }
    
    func getTopRatedMovies() {
        remoteDatamanager?.getTopRatedMovies()
    }
    
    func getUpcomingMovies() {
        remoteDatamanager?.getUpcomingMovies()
    }
    
   
}

extension HomeMoviesInteractor: HomeMoviesRemoteDataManagerOutputProtocol {
   
    // TODO: Implement use case methods
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        presenter?.pushTrendingMovieInfo(trendingMovies: trendingMovies)
    }
    
    func pushNowPlayingMovieInfo(nowPlayingMovies: [Movie]) {
        presenter?.pushNowPlayingMovieInfo(nowPlayingMovies: nowPlayingMovies)
    }
 
    func pushPopularMovieInfo(popularMovies: [Movie]) {
        presenter?.pushPopularMovieInfo(popularMovies: popularMovies)
    }
    
    func pushTopRatedMovieInfo(topRatedMovies: [Movie]) {
        presenter?.pushTopRatedMovieInfo(topRatedMovies: topRatedMovies)
    }
    
    func pushUpcomingMovieInfo(upcomingMovies: [Movie]) {
        presenter?.pushUpcomingMovieInfo(upcomingMovies: upcomingMovies)
    }
}
