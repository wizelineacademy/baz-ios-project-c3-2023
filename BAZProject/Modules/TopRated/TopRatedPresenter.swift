//
//  TopRatedPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import Foundation

class TopRatedPresenter  {
    
    // MARK: Properties
    weak var view: TopRatedViewProtocol?
    var interactor: TopRatedInteractorInputProtocol?
    var router: TopRatedRouterProtocol?
    var movies: [Movie]?
    
}

extension TopRatedPresenter: TopRatedPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension TopRatedPresenter: TopRatedInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
