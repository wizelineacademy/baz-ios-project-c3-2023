//
//  MSPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSPresenter {
    weak var view: MSViewInputProtocol?
    let interactor: MSInteractorInputProtocol
    let router: MSRouterProtocol
    
    init(view: MSViewInputProtocol?, interactor: MSInteractorInputProtocol, router: MSRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MSPresenter: MSViewOutputProtocol {
    func didLoadView() {
        self.interactor.fetchViewData()
    }
    
    func seakMovies(by text: String?) {
        self.interactor.fetchMovies(by: text)
    }
    
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
}

extension MSPresenter: MSInteractorOutputProtocol {
    func setView(with data: MSEntity) {
        self.view?.setView(with: data)
    }
    
    func didReceive(_ movies: [Movie]) {
        self.view?.set(movies: movies)
    }
    
    func didReceive(_ error: Error) {
        self.view?.show(error)
    }
}
