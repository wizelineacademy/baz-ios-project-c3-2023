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

    private let movieApi : MovieAPI = MovieAPI()
    
    func getTrendingMovies() {
        if let url = URLBuilder.shared.getUrl(urlType: .trending) {
            movieApi.getMovies(for: url) { trendingMovies in
                guard let trendingMovies = trendingMovies else { return }
                self.remoteRequestHandler?.pushTrendingMovieInfo(trendingMovies: trendingMovies)
            }
        }
    }
    
    func getNowPlayingMovies() {
        if let url = URLBuilder.shared.getUrl(urlType: .nowPlaying) {
            movieApi.getMovies(for: url) { nowPlayingMovies in
                guard let nowPlayingMovies = nowPlayingMovies else { return }
                self.remoteRequestHandler?.pushNowPlayingMovieInfo(nowPlayingMovies: nowPlayingMovies)
                
            }
        }
    }
    
    func getPopularMovies() {
        if let url = URLBuilder.shared.getUrl(urlType: .popular) {
            movieApi.getMovies(for: url) { popularMovies in
                guard let popularMovies = popularMovies else { return }
                self.remoteRequestHandler?.pushPopularMovieInfo(popularMovies: popularMovies)
            }
        }
    }
    
    func getTopRatedMovies() {
        if let url = URLBuilder.shared.getUrl(urlType: .topRated) {
            movieApi.getMovies(for: url) { topRatedMovies in
                guard let topRatedMovies = topRatedMovies else { return }
                self.remoteRequestHandler?.pushTopRatedMovieInfo(topRatedMovies: topRatedMovies)
            }
        }
    }
    
    func getUpcomingMovies() {
        if let url = URLBuilder.shared.getUrl(urlType: .upcoming) {
            movieApi.getMovies(for: url) { upcomingMovies in
                guard let upcomingMovies = upcomingMovies else { return }
                self.remoteRequestHandler?.pushTopRatedMovieInfo(topRatedMovies: upcomingMovies)
            }
        }
    }
}
