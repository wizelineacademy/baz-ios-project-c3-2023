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
    
    func getMoviesData(from api: URLApi, dispatchGroup: DispatchGroup?, completionHandler: @escaping () -> Void) {
        dispatchGroup?.enter()
        MovieAPI.getApiData(from: api) { [weak self] data in
            if let movies =  DecodeUtility.decode(Movies.self, from: data) {
                self?.movieApiData.getArrayDataMovie?[api] = movies
                completionHandler()
            }
        }
    }
}
