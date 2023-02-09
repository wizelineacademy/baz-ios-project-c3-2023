//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import Foundation

class MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    var view: MovieDetailViewProtocol?
    var interceptor: MovieDetailInterceptorInputProtocol?
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol{
    func viewDidLoad(){
        
    }
}
