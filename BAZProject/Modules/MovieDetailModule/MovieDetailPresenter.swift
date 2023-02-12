//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    var view: MovieDetailViewProtocol?
    var interceptor: MovieDetailInterceptorInputProtocol?
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func viewDidLoad() {
        getUI()
    }
    
    func getUI() {
        if let data = interceptor?.data, let image = data.posterPath, let overviewTextView =  view?.overviewTextView {
            MovieAPI.getImage(from: image , handler: { image in
                self.view?.poster.image = image
            })
            overviewTextView.text = data.overview
        }
    }

}
