//
//  MainInteractor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import Foundation

final class MainInteractor: MainInteractorInputProtocol {
    var presenter: MainInteractorOutputProtocol?
    var movieApi: MovieAPI = MovieAPI()
    
    func getMoviesData(from api:URLApi){
        movieApi.getApiData(from: api) { [weak self] data in
            do{
                if let movies =  DecodeUtility.decode(Movies.self, from: data){
                    print(movies)
                    self?.movieApi.getDataMovies = movies
                    self?.presenter?.reloadData()
                }
            }
        }
    }
}
