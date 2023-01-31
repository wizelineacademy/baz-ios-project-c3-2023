//
//  HomeMoviesPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation

class HomeMoviesPresenter: HomeMoviesPresenterProtocol  {
   
    // MARK: Properties
    weak var view: HomeMoviesViewProtocol?
    var interactor: HomeMoviesInteractorInputProtocol?
    var router: HomeMoviesRouterProtocol?
    var trendingMovies: [Movie] = []
    
    // TODO: implement presenter methods
    func getTrendingMovies() {
        interactor?.getTrendingMovies()
    }
    
    func getOneTrendingMovie(index: Int) -> Movie {
        return self.trendingMovies[index]
    }
    
    func getTrendingMovieCount() -> Int {
        if self.trendingMovies.count > 1{
            return 5
        }
        return 0
    }
    
    
}


extension HomeMoviesPresenter: HomeMoviesInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        self.trendingMovies = trendingMovies
        view?.loadTrendingMovies()
    }
    
}
