//
//  MainInteractor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import Foundation

final class MainInteractor: MainInteractorInputProtocol {
    var presenter: MainInteractorOutputProtocol?
    var movieApiData: DataHelper = DataHelper()
    var countMovieWatched: Int = 0
    let saveData: SaveMovies = SaveMovies()
    
    func getMoviesData(from api: URLApi, dispatchGroup: DispatchGroup?, completionHandler: @escaping () -> Void) {
        dispatchGroup?.enter()
        MovieAPI.getApiData(from: api) { [weak self] data in
            if let movies =  DecodeUtility.decode(Movies.self, from: data) {
                self?.movieApiData.getArrayDataMovie?[api] = movies
                completionHandler()
            }
        }
    }
    
    func saveMovieWatched(idMovie: Int) {
        do {
            if !saveData.isSave(title: .watchedMovies, idMovie: idMovie) {
                try saveData.save(idMovie, title: .watchedMovies)
            }
        } catch {
            debugPrint("Error")
        }
    }
}
