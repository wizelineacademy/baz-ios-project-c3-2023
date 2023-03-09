//
//  MLPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import Foundation

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
    /** Call an interactor method to fetch the title for the view */
    func didLoadView() {
        self.interactor.fetchViewTitle()
    }
    
    /**
     Call the interactor method to look for updates in the received data and makes the next page, the current page
     - Parameters:
        - data: a MovieList object
     */
    func lookForUpdates(in data: MoviesList) {
        let moviesData = data.setNextPage(with: data.currentPage)
        self.interactor.updateMovies(of: moviesData)
    }
    
    /**
     Call a router method to push the next view controller with the received movie
     - Parameters:
        - movie: a movie object
     */
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
    
    /**
     Fetch for the movies next page, calling the corresponding interactor method
     - Parameters:
        - data: a MovieList Object
     */
    func fetchMoreMovies(with data: MoviesList) {
        self.interactor.updateMovies(of: data)
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
     Call a view method to configure the received movies data
     - Parameters:
        - data:a MovieList object
     */
    func didFindMovies(_ data: MoviesList) {
        self.view?.setMovies(with: data)
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
