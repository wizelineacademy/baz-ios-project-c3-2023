//
//  HomeMoviesPresenter.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

class HomeMoviesPresenter: HomeMoviesPresenterProtocol  {
    
    // MARK: Properties
    weak var view: HomeMoviesViewProtocol?
    var interactor: HomeMoviesInteractorInputProtocol?
    var router: HomeMoviesRouterProtocol?
    
    var selectedCategory: MovieCategory?
    
    private var movies: [Movie] = []
    private var searchResult: [Movie] = []
    
    
    func loadingView(){
        interactor?.getMovies(categoryMovieType: selectedCategory ?? .trending)
    }
    
    // MARK: - HomeMoviesPresenterProtocol Functions
    func getMovieCount() -> Int {
        return self.movies.count
    }
    
    func getMovie(indexPathRow: Int) -> Movie {
        return movies[indexPathRow]
    }
    
    func getSearchedMovieCount() -> Int {
        return self.searchResult.count
    }
    
    func getSearchedMovie(indexPathRow: Int) -> Movie {
        return self.searchResult[indexPathRow]
    }
    
    func getSearchedMovies(searchTerm: String) {
        interactor?.getSearchedMovies(searchTerm: searchTerm)
    }
    
    func getInformationMovie(idMovie: Int) {
        interactor?.getInformationMovie(idMovie: idMovie)
    }
}

// MARK: - HomeMoviesInteractorOutputProtocol
extension HomeMoviesPresenter: HomeMoviesInteractorOutputProtocol {
    
    // MARK: - HomeMoviesInteractorOutputProtocol functions
    func pushSearchedMoviesData(moviesData: [Movie]) {
        self.searchResult = moviesData
        
        self.view?.reloadCollectionViewSearchedData()
    }
    
    func pushMoviesData(moviesData: [Movie]) {
        self.movies = moviesData
        self.view?.reloadCollectionViewData()
    }
    
    func pushInformationMovieData(movieData: InformationMovie) {
        if let view = view{
            self.view?.catchResponse(withMessage: nil)
            self.router?.goToInformationMovie(informationMovieData: movieData, view: view)
        }
    }
    
    func catchResponse(withMessage: String) {
        self.view?.catchResponse(withMessage: withMessage)
    }
}
