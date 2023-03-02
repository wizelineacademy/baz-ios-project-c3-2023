//
//  HomeInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomeBusinessLogic: AnyObject {
    func fetchMoviesBySection(request: Home.FetchMoviesBySection.Request)
    func getMoviesSection()
    func saveMovieWatched(request: Home.SaveMovieWatched.Request)
}


class HomeInteractor: HomeBusinessLogic {
    
    // MARK: Properties
    let moviesWorker = MoviesWorker(movieService: MoviesAPI())
    var moviesWatched: [MovieSearch] = UserDefaults.standard.object(forKey: "moviesWatched") as? [MovieSearch] ?? []
    
    // MARK: Properties VIP
    var presenter: HomePresentationLogic?
        
    func fetchMoviesBySection(request: Home.FetchMoviesBySection.Request) {
        moviesWorker.getMoviesByType(request.section) { [weak self] movies, message in
            guard let self = self else {
                return
            }
            if let message = message {
                self.presenter?.presentErrorMessage(error: Home.FetchMoviesBySection.Error(message: message))
            }
            self.presenter?.presentFechedMoviesForSection(response: Home.FetchMoviesBySection.Response(section: request.section, movies: movies))
        }
    }
    
    func getMoviesSection() {
        let sections: [fetchMoviesTypes] = [.popular, .nowPlaying, .topRated, .trending, .upComing]
        presenter?.presentMovieSections(response: Home.GetMoviesSection.Response(sections: sections))
    }
    
    func saveMovieWatched(request: Home.SaveMovieWatched.Request) {
        moviesWatched.append(request.movie)
        let response = Home.SaveMovieWatched.Response(movies: moviesWatched)
        presenter?.presentMoviesWatched(response: response)
    }
}

