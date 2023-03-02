//
//  NowPlayingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class NowPlayingPresenter  {
    
    // MARK: Properties
    weak var view: NowPlayingViewProtocol?
    var interactor: NowPlayingInteractorInputProtocol?
    var router: NowPlayingRouterProtocol?
    var movies: [Movie]?
    
}

extension NowPlayingPresenter: NowPlayingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.movies?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension NowPlayingPresenter: NowPlayingInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}

