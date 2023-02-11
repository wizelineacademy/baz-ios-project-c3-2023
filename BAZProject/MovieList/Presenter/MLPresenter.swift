//
//  MLPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MLPresenter {
    weak var view: MLViewInputProtocol?
    let interactor: MLInteractorInputProtocol
    let router: MLRouterProtocol
    
    init(view: MLViewInputProtocol? = nil, interactor: MLInteractorInputProtocol, router: MLRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MLPresenter: MLViewOutputProtocol {
    func didLoadView() {
        self.interactor.fetchData()
    }
    
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
}

extension MLPresenter: MLInteractorOutputProtocol {
    func set(title: String) {
        self.view?.setTitle(title)
    }
    
    func didFind(movies: [Movie]) {
        self.view?.setMovies(movies)
    }
    
    func didFind(error: Error) {
        self.view?.show(error)
    }
}
