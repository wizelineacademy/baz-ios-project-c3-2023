//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import UIKit

class TrendingPresenter  {
    
    // MARK: Properties
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?
    var movies: [Movie]?
    
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.movies?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
