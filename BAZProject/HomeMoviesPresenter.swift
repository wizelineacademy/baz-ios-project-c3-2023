//
//  HomeMoviesPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import UIKit

class HomeMoviesPresenter: HomeMoviesPresenterProtocol  {
 
    // MARK: Properties
    weak var view: HomeMoviesViewProtocol?
    var interactor: HomeMoviesInteractorInputProtocol?
    var router: HomeMoviesRouterProtocol?
    private let movieApi : MovieAPI = MovieAPI()
    private var indexSelected : Int = 0
    private var firstLoad : Bool = true
    var categoriesMovies: [Movie] = []
    var toShowMovies: [Movie] = []

    
    // TODO: implement presenter methods
    func getTrendingMovies() {
        interactor?.getTrendingMovies()
    }
    
    func getOneMovie(index: Int) -> Movie {
        return self.toShowMovies[index]
    }
    
    func getMoviesCount() -> Int {
        return self.toShowMovies.count
    }
    
    func getOneCategorieMovie(index: Int) -> Movie {
        return self.categoriesMovies[index]
    }
    
    func getCategoriesMoviesCount() -> Int {
        if categoriesMovies.count > 1 { return 5 }
        return 0
    }
    
    func getImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let urlImage = self.toShowMovies[index].poster_path{
            movieApi.getImage(for: urlImage) { movieImage in
                if let movieImage = movieImage{
                    completion(movieImage)
                }
            }
        }
    }
    
    func getCategorieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let urlImage = self.categoriesMovies[index].backdrop_path{
            movieApi.getImage(for: urlImage) { categorieImage in
                if let categorieImage = categorieImage{
                    completion(categorieImage)
                }
            }
        }
    }
    
    func selectFilterMovies(index: Int) {
        if index == indexSelected {return}
        switch index{
        case 0:
            indexSelected = 0
            getTrendingMovies()
        case 1:
            indexSelected = 1
            interactor?.getNowPlayingMovies()
        case 2:
            indexSelected = 2
            interactor?.getPopularMovies()
        case 3:
            indexSelected = 3
            interactor?.getTopRatedMovies()
        case 4:
            indexSelected = 4
            interactor?.getUpcomingMovies()
        default:
            break
        }
    }
    
    
}


extension HomeMoviesPresenter: HomeMoviesInteractorOutputProtocol {
   
    // TODO: implement interactor output methods
    
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        self.toShowMovies = trendingMovies
        view?.loadMovies()
        if firstLoad{
            self.firstLoad = false
            self.categoriesMovies = trendingMovies
            view?.loadTrendingMovies()
        }
    }
    
    func pushNowPlayingMovieInfo(nowPlayingMovies: [Movie]) {
        self.toShowMovies = nowPlayingMovies
        view?.loadMovies()
    }
    
    func pushPopularMovieInfo(popularMovies: [Movie]) {
        self.toShowMovies = popularMovies
        view?.loadMovies()
    }
    
    func pushTopRatedMovieInfo(topRatedMovies: [Movie]) {
        self.toShowMovies = topRatedMovies
        view?.loadMovies()
    }
    
    func pushUpcomingMovieInfo(upcomingMovies: [Movie]) {
        self.toShowMovies = upcomingMovies
        view?.loadMovies()
    }
    
    
}
