//
//  FavoriteMovieInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import Foundation

final class FavoriteMovieInteractor {
    var presenter: FavoriteMovieInteractorOutputProtocol?
    var getDataMovies: [Movie]?
    var getIdMovies: [Int]?
    let saveData: SaveMovies = SaveMovies()
}

extension FavoriteMovieInteractor: FavoriteMovieInteractorInputProtocol {
    func getFavoriteMovies(from api: URLApi) {
        getDataMovies = nil
        getIdMovies?.forEach({ idMovie in
            getFavoriteMovie(from: api, idMovie: idMovie)
        })
    }
    
    func getFavoriteMovie(from api: URLApi, idMovie: Int) {
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
            getIdMovies = try? saveData.load(title: .favoriteMovies)
        }
    }
}
