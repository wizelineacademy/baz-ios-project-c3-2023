//
//  MDPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation

final class MDPresenter {
    
    private let view: MovieDetailView
    private let router: MDRouter
    private let interactor: MDInteractorProtocol
    
    init(view: MovieDetailView, router: MDRouter, interactor: MDInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension MDPresenter: MDEventHandler {
    func didLoadView() {
        self.interactor.fetchData()
    }
}

extension MDPresenter: MDOutputProtocol {
    func find(_ movie: Movie) {
        self.view.setView(with: movie)
    }
}
