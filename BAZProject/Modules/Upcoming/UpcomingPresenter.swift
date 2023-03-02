//
//  UpcomingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class UpcomingPresenter  {
    
    // MARK: Properties
    weak var view: UpcomingViewProtocol?
    var interactor: UpcomingInteractorInputProtocol?
    var router: UpcomingRouterProtocol?
    var movies: [Movie]?
    
}

extension UpcomingPresenter: UpcomingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.movies?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension UpcomingPresenter: UpcomingInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}

