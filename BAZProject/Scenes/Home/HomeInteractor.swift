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
}

protocol HomeDataStore {
    var section: fetchMoviesTypes? { get }
    var movies: [Movie]? { get }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: Properties
    let moviesWorker = MoviesWorker(movieService: MoviesAPI())
    var movies: [Movie]?
    var section: fetchMoviesTypes?
    
    // MARK: Properties VIP
    var presenter: HomePresentationLogic?
        
    func fetchMoviesBySection(request: Home.FetchMoviesBySection.Request) {
        self.section = request.section
        moviesWorker.getMoviesByType(request.section) { [weak self] movies, message in
            guard let self = self else {
                return
            }
            if let message = message {
                self.presenter?.presentErrorMessage(error: Home.FetchMoviesBySection.Error(message: message))
            }
            self.movies = movies
            self.presenter?.presentFechedMoviesForSection(response: Home.FetchMoviesBySection.Response(section: request.section, movies: movies, numberOfMoviesToShow: 10))
        }
    }
    
    func getMoviesSection() {
        let sections: [fetchMoviesTypes] = [.popular, .nowPlaying, .topRated, .trending, .upComing]
        presenter?.presentMovieSections(response: Home.GetMoviesSection.Response(sections: sections))
    }
}

