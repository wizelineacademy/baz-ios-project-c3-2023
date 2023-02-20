//
//  MSPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

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
    /** Call an interactor method to fetch the needed data */
    func didLoadView() {
        self.interactor.fetchViewData()
    }
    
    /**
     Call an interactor method to fetch movies by the given text
     - Parameters:
        - text: a string wich the search is performed
     */
    func searchMovies(by text: String?) {
        self.interactor.fetchMovies(by: text)
    }
    
    /**
     Call a router method to show the next view controller wuth the given movie
     - Parameters:
        - movie: a Movie object
     */
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
}

extension MSPresenter: MSInteractorOutputProtocol {
    /**
     Call a view method to set it with the given data
     - Parameters:
        - data: a MSEntity object
     */
    func setView(with data: MSEntity) {
        self.view?.setupView(with: data)
    }
    
    /**
     Call a view method to set the received movies
     - Parameters:
        - movies: a movie array
     */
    func didReceive(_ movies: [Movie]) {
        self.view?.set(movies: movies)
    }
    
    /**
     Call a view method to show the given error
     - Parameters:
        - error: an Error object
     */
    func didReceive(_ error: Error) {
        self.view?.show(error)
    }
}
