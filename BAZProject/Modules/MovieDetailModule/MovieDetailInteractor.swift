//
//  MovieDetailInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import Foundation

final class MovieDetailInteractor {
    weak var presenter: MovieDetailInteractorOutputProtocol?
    
    var movieApiData: DataHelper = DataHelper()
    var data: Movie?
    let saveData: SaveMovies = SaveMovies()
    
}

extension MovieDetailInteractor: MovieDetailInterceptorInputProtocol {
    func deleteToFavoriteMovie() {
        guard let idMovie = data?.id else { return }
        saveData.delete(title: .favoriteMovies, idMovie: idMovie)
    }
    
    func saveFavoriteMovie() {
        do {
            guard let idMovie = data?.id else { return }
            if !saveData.isSave(title: .favoriteMovies, idMovie: idMovie) {
                try saveData.save(idMovie, title: .favoriteMovies)
            }
        } catch {
            debugPrint("Error")
        }
    }
    
    func getMoviesDataWithId(from api: URLApi, id idMovie: Int, structure: Codable.Type) {
        MovieAPI.getApiData(from: api, id: idMovie) { [weak self] data in
            if let movies =  DecodeUtility.decode(structure.self, from: data) {
                self?.movieApiData.getArrayDataMovie?[api] = movies
                self?.presenter?.reloadData()
            }
        }
    }
    
}
