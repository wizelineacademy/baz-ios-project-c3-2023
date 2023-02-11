//
//  MDPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation

final class MDPresenter {
    
    weak var view: MDViewInputProtocol?
    let interactor: MDInteractorInputProtocol
    
    init(view: MDViewInputProtocol?, interactor: MDInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension MDPresenter: MDViewOutputProtocol {
    func didLoadView() {
        self.interactor.fetchData()
    }
}

extension MDPresenter: MDInteractorOutputProtocol {
    func present(_ movie: Movie) {
        self.view?.setView(with: movie)
    }
}
