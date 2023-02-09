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
        getUI()
    }
    
    func getUI(){
        if let data = interceptor?.data, let image = data.posterPath {
            interceptor?.movieApi.getImage(from: image , handler: { image in
                self.view?.poster.image = image
            })
            view?.overviewTextView.text = data.overview
            view?.overviewTextView.isScrollEnabled = false
        }
    }
}
