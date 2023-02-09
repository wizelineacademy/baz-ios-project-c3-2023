//
//  MovieDetailInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import Foundation

class MovieDetailInterceptor: MovieDetailInterceptorInputProtocol {
    var movieApi: MovieAPI = MovieAPI.movieAPISharedInstance
    var data: Result?
    var presenter: MovieDetailInteractorOutputProtocol?
}
