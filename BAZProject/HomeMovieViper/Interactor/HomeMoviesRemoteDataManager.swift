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
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getTrendingMovies() {
        let trendingUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(self.apiKey)"
        movieApi.getMovies(for: trendingUrl) { trendingMovies in
            guard let trendingMovies = trendingMovies else {return}
            self.remoteRequestHandler?.pushTrendingMovieInfo(trendingMovies: trendingMovies)
        }
    }
    
    func getNowPlayingMovies(){
        let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(self.apiKey)"
        movieApi.getMovies(for: nowPlayingUrl) { nowPlayingMovies in
            guard let nowPlayingMovies = nowPlayingMovies else {return}
            self.remoteRequestHandler?.pushNowPlayingMovieInfo(nowPlayingMovies: nowPlayingMovies)
            
        }
    }
    
    func getPopularMovies() {
        let popularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)"
        movieApi.getMovies(for: popularUrl) { popularMovies in
            guard let popularMovies = popularMovies else {return}
            self.remoteRequestHandler?.pushPopularMovieInfo(popularMovies: popularMovies)
        }
    }
    
    func getTopRatedMovies() {
        let topRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(self.apiKey)"
        movieApi.getMovies(for: topRatedUrl) { topRatedMovies in
            guard let topRatedMovies = topRatedMovies else {return}
            self.remoteRequestHandler?.pushTopRatedMovieInfo(topRatedMovies: topRatedMovies)
        }
    }
    
    func getUpcomingMovies() {
        let upcomingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(self.apiKey)"
        movieApi.getMovies(for: upcomingUrl) { upcomingMovies in
            guard let upcomingMovies = upcomingMovies else {return}
            self.remoteRequestHandler?.pushTopRatedMovieInfo(topRatedMovies: upcomingMovies)
        }
    }
}
