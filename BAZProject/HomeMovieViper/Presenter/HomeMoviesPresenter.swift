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

    func viewDidLoad() {
        interactor?.getTrendingMovies()
    }
    
    /// Get the movie from the toShowMovies  array
    ///
    /// - Parameter index: Int index of the movie to get from the array
    /// - Returns: A Movie struct from the array of toShowMovies
    func getOneMovie(index: Int) -> Movie {
        return self.toShowMovies[index]
    }
    
    /// Returns the toShowMovies  array count
    ///
    /// - Returns: An Int that is the toShowMovies array count
    func getMoviesCount() -> Int {
        return self.toShowMovies.count
    }
    
    /// Get the categorie movie from the categoriesMovies array
    ///
    /// - Parameter index: Int index of the movie to get from the array
    /// - Returns: A Movie struct from the array of categoriesMovies
    func getOneCategorieMovie(index: Int) -> Movie {
        return self.categoriesMovies[index]
    }
    
    /// Returns the categoriesMovies array count, if the categoriesMovies array is more than 1 always return 5
    ///
    /// - Returns: An Int that is the categoriesMovies array count
    func getCategoriesMoviesCount() -> Int {
        if categoriesMovies.count > 1 { return 5 }
        return 0
    }
    
    /// Get an image from the MovieApi class using the index of the movies array and return and UIImage
    ///
    /// - Parameter index: Index of the array movies for get the string url image
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let urlImage = self.toShowMovies[index].poster_path{
            movieApi.getImage(for: urlImage) { movieImage in
                if let movieImage = movieImage{
                    completion(movieImage)
                }
            }
        }
    }
    
    /// Get an image from the MovieApi class using the index of the movies array and return and UIImage
    ///
    /// - Parameter index: Index of the array categoryMovies for get the string url image
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getCategorieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let urlImage = self.categoriesMovies[index].backdrop_path {
            movieApi.getImage(for: urlImage) { categorieImage in
                if let categorieImage = categorieImage{
                    completion(categorieImage)
                }
            }
        }
    }
    
    /// Get the category title depending the index of the cell
    ///
    /// - Parameter index: Index of the array categoryMovies for get the string name
    /// - Returns: name of the cell in string format
    func getCategorieTitle(index: Int) -> String {
        switch index{
            case 0:
                return "Trending"
            case 1:
                return "Now Playing"
            case 2:
                return "Popular"
            case 3:
                return "Top rated"
            case 4:
                return "Upcoming"
            default:
                return ""
        }
    }
    
    /// Get the movies filters depending tha index of the cell
    ///
    /// - Parameter index: Index of the array categoryMovies for get the movies type
    func selectFilterMovies(index: Int) {
        if index == indexSelected { return }
        switch index {
            case 0:
                indexSelected = 0
                interactor?.getTrendingMovies()
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
    
    func goToDetails(index: Int) {
        if let view = view{
            router?.goToDetails(from: view,idMovie: self.toShowMovies[index].id)
        }
    }
}


extension HomeMoviesPresenter: HomeMoviesInteractorOutputProtocol {
   
    func pushTrendingMovieInfo(trendingMovies: [Movie]) {
        self.toShowMovies = trendingMovies
        view?.loadMovies()
        if firstLoad {
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
