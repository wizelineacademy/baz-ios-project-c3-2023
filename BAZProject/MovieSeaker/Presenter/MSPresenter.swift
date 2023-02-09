//
//  MSPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSPresenter {
    private let view: MovieSeakerView
    private let router: MSRouter
    private let interactor: MSInteractorProtocol
    
    init(view: MovieSeakerView, router: MSRouter, interactor: MSInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension MSPresenter: MSEventHandler {
    func didLoadView() {
        self.interactor.fetchViewData()
    }
    
    func seakMovies(by text: String?) {
        self.interactor.fetchMovies(by: text)
    }
    
    func didSelect(_ movie: Movie) {
        self.interactor.check(movie)
    }
}

extension MSPresenter: MSOutputProtocol {
    func setView(with data: MSEntity) {
        self.view.setView(with: data)
    }
    
    func didReceive(_ movies: [Movie]) {
        self.view.set(movies: movies)
    }
    
    func didReceive(_ error: Error) {
        self.view.show(error)
    }
    
    func goNext(_ viewController: UIViewController) {
        self.router.goNext(viewController)
    }
}
