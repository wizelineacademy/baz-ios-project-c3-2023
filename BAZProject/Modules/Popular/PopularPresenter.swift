//
//  PopularPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class PopularPresenter  {
    
    // MARK: Properties
    weak var view: PopularViewProtocol?
    var interactor: PopularInteractorInputProtocol?
    var router: PopularRouterProtocol?
    var movies: [Movie]?
    
}

extension PopularPresenter: PopularPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.movies?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension PopularPresenter: PopularInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}

