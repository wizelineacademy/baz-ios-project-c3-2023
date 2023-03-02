//
//  WatchedMovieInteractor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

final class WatchedMovieInteractor {
    var presenter: WatchedMovieInteractorOutputProtocols?
    var getDataMovies: [Movie]?
    var getIdMovies: [Int]?
    let saveData: SaveMovies = SaveMovies()
}

extension WatchedMovieInteractor: WatchedMovieInteractorInputProtocols {
    func getWatchedMovies(from api: URLApi) {
        getDataMovies = nil
        getIdMovies?.forEach({ idMovie in
            getWatchedMovie(from: api, idMovie: idMovie)
        })
    }
    
    func getWatchedMovie(from api: URLApi, idMovie: Int) {
        MovieAPI.getApiData(from: api, id: idMovie) { [weak self] data in
            if let movies =  DecodeUtility.decode(Movie.self, from: data) {
                if ((self?.getDataMovies?.isEmpty) != nil) {
                    self?.getDataMovies?.append(movies)
                } else {
                    self?.getDataMovies = [movies]
                }
            }
        }
    }
    
    func setIdMovies() {
        do {
            getIdMovies = nil
            getIdMovies = try? saveData.load(title: .watchedMovies)
        }
    }

    
}
