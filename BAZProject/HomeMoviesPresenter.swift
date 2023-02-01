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
    private let movieApi = MovieAPI()
    private var indexSelected = 0
    var categoriesMovies: [Movie] = []
    var toShowMovies: [Movie] = []
    
    // TODO: implement presenter methods
    func getTrendingMovies() {
        interactor?.getTrendingMovies()
    }
    
    func getNowPlayingMovies() {
        interactor?.getNowPlayingMovies()
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
            getNowPlayingMovies()
        default:
            break
        }
    }
    
    
}


extension HomeMoviesPresenter: HomeMoviesInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        self.toShowMovies = trendingMovies
        self.categoriesMovies = trendingMovies
        view?.loadTrendingMovies()
        view?.loadMovies()
    }
    
    func pushNowPlayingMovieInfo(nowPlayingMovies: [Movie]) {
        self.toShowMovies = nowPlayingMovies
        view?.loadMovies()
    }
    
    
}
