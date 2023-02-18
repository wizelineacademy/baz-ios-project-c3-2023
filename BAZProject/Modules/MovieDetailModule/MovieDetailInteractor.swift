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
    var data: Result?
    let saveData: SaveMovies = SaveMovies()
    
}

extension MovieDetailInteractor: MovieDetailInterceptorInputProtocol {
    func saveMovie() {
        debugPrint("test of saveMovie")
        var allDataMovie: [Result]?
        do {
            allDataMovie = try? saveData.load(title: saveData.moviesWatched)
            guard let data = data else { return }
            allDataMovie?.append(data)
            guard let allDataMovie = allDataMovie else { return }
            try saveData.save(allDataMovie, title: saveData.moviesWatched)
        } catch {
            debugPrint("error")
        }
        do {
            if let movies =  try? saveData.load(title: saveData.moviesWatched) {
                debugPrint(movies)
            }
        }
    }
    
    func getMoviesData(from api: URLApi, structure: Codable.Type) {
        MovieAPI.getApiData(from: api) { [weak self] data in
            do {
                if let movies =  DecodeUtility.decode(structure.self, from: data) {
                    self?.movieApiData.getArrayDataMovie?[api] = movies
                    self?.presenter?.reloadData()
                }
            }
        }
    }
    
    func getMoviesDataWithId(from api: URLApi, id idMovie: Int, structure: Codable.Type) {
        MovieAPI.getApiData(from: api, id: idMovie) { [weak self] data in
            do {
                if let movies =  DecodeUtility.decode(structure.self, from: data) {
                    self?.movieApiData.getArrayDataMovie?[api] = movies
                    self?.presenter?.reloadData()
                }
            }
        }
    }
    
}
