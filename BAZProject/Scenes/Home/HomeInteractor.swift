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
    func saveMovieWatched(request: Home.SaveMovieWatched.Request)
    func getMoviesSection()
    func subscribeMovieWatchObserver()
    
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
        let sections: [fetchMoviesTypes] = [.watched, .popular, .nowPlaying, .topRated, .trending, .upComing]
        presenter?.presentMovieSections(response: Home.GetMoviesSection.Response(sections: sections))
    }
    
    func saveMovieWatched(request: Home.SaveMovieWatched.Request) {
        if moviesWatched.count == 0 || (moviesWatched.count < 10 && !isDuplicateMovieById(movieToEvaluate: request.movie)){
            moviesWatched.append(request.movie)
        } else if moviesWatched.count >= 10 && !isDuplicateMovieById(movieToEvaluate: request.movie) {
            moviesWatched.remove(at: 0)
            moviesWatched.append(request.movie)
        }
        let response = Home.SaveMovieWatched.Response(movies: moviesWatched)
        presenter?.presentMoviesWatched(response: response)
    }
    
    private func isDuplicateMovieById(movieToEvaluate: MovieSearch) -> Bool {
        moviesWatched.filter { $0.id == movieToEvaluate.id }.count > 0
    }
    
    func subscribeMovieWatchObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.listenMovieWatchObserver(_:)), name: NSNotification.Name("movie.watch"), object: nil)
    }
    
    @objc func listenMovieWatchObserver(_ notification: Notification) {
        if let movie = notification.object as? MovieSearch {
            let request = Home.SaveMovieWatched.Request(movie: movie)
            saveMovieWatched(request: request)
        }
    }
}

