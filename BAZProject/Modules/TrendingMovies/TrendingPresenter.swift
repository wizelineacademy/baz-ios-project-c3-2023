//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import Foundation

class TrendingPresenter  {
    
    // MARK: Properties
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?
    var movies: [Movie]?
    
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
