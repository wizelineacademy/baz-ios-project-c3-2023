//
//  MLPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MLPresenter: MLPresenterProtocol {
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
    /** Call an interactor method to fetch the needed data */
    func didLoadView() {
        self.interactor.fetchData()
    }
    
    /**
     Call a router method to push the next view controller with the received movie
     - Parameters:
        - movie: a movie object
     */
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
}

extension MLPresenter: MLInteractorOutputProtocol {
    /**
     Call a view method to configure the view title
     - Parameters:
        - title: a string with the name of the movie
     */
    func set(title: String) {
        self.view?.setTitle(title)
    }
    
    /**
     Call a view method to configure the list of received movies
     - Parameters:
        - movies:a Movie array
     */
    func didFind(movies: [Movie]) {
        self.view?.setMovies(movies)
    }
    
    /**
     Call a view method to show the received error
     - Parameters:
        - error: an error object
     */
    func didFind(error: Error) {
        self.view?.show(error)
    }
}
