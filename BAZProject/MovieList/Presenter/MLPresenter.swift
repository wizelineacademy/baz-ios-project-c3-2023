//
//  MLPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MLPresenter {
    let interactor: MLInteractorProtocol
    let view: MovieListView
    let router: MLRouter
    
    init(interactor: MLInteractorProtocol, view: MovieListView, router: MLRouter) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
}

extension MLPresenter: MLEventHandler {
    func didLoadView() {
        self.interactor.fetchData()
    }
    
    func didSelect(movie: Movie) {
        self.interactor.check(movie: movie)
    }
}

extension MLPresenter: MLOutputProtocol {
    func set(title: String) {
        self.view.setTitle(title)
    }
    
    func didFind(movies: [Movie]) {
        self.view.setMovies(movies)
    }
    
    func didFind(error: Error) {
        self.view.show(error)
    }
    
    func goNext(_ viewController: UIViewController) {
        self.router.goNext(viewController)
    }
}
