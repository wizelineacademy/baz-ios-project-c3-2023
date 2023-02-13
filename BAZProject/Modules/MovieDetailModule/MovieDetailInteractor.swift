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
}
