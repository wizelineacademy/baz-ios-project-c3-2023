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
    /** Call a interactor method to fetch the needed data */
    func didLoadView() {
        self.interactor.fetchMovieDetail()
    }
}

extension MDPresenter: MDInteractorOutputProtocol {
    /**
     Call a view method to configure the view with the received movie
     - Parameters:
        - movie: a Movie object
     */
    func present(_ movie: Movie) {
        self.view?.setupView(with: movie)
    }
}
