//
//  HomeMoviesRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation

class HomeMoviesRemoteDataManager:HomeMoviesRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol?
    
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi = MovieAPI()
    
    func getTrendingMovies() {
        let trendingUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(self.apiKey)"
        movieApi.getMovies(for: trendingUrl) { movies in
            guard let movies = movies else {return}
            self.remoteRequestHandler?.pushTrendingMovieInfo(trendingMovies: movies)
        }
    }
    
    func getNowPlayingMovies(){
        let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(self.apiKey)"
        movieApi.getMovies(for: nowPlayingUrl) { movies in
            guard let movies = movies else {return}
            self.remoteRequestHandler?.pushNowPlayingMovieInfo(nowPlayingMovies: movies)
            
        }
    }
}
