//
//  MovieDetailInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import Foundation

final class MovieDetailInteractor: MovieDetailInterceptorInputProtocol {
    var movieApiData: DataHelper = DataHelper()
    var data: Result?
    weak var presenter: MovieDetailInteractorOutputProtocol?
    
    func getMoviesData(from api: URLApi) {
        MovieAPI.getApiData(from: api) { [weak self] data in
            do {
                if let movies =  DecodeUtility.decode(Movies.self, from: data) {
                    self?.movieApiData.getDataMovies = movies
                    self?.presenter?.reloadData()
                }
            }
        }
    }
}
