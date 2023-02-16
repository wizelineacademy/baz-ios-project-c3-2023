//
//  InformationMoviesPresenter.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

class InformationMoviesPresenter: InformationMoviesPresenterProtocol {
    
    
    // MARK: Properties
    weak var view: InformationMoviesViewProtocol?
    var interactor: InformationMoviesInteractorInputProtocol?
    var router: InformationMoviesRouterProtocol?
    var informationMovieData: InformationMovie?
    private var similarMovies: [Movie] = []
    
    // MARK: - InformationMoviesPresenterProtocol functions
    func loadingView() {
        interactor?.getMovieSimilar(idMovie: informationMovieData?.id ?? 0)
    }
    
    func getSimilarMoviesCount() -> Int {
        self.similarMovies.count
    }
    
    func getSimilarMovie(indexPathRow: Int) -> Movie {
        self.similarMovies[indexPathRow]
    }
    
    func getInformationMovie(idMovie: Int) {
        interactor?.getInformationMovie(idMovie: idMovie)
    }
    
}

// MARK: - InformationMoviesInteractorOutputProtocol
extension InformationMoviesPresenter: InformationMoviesInteractorOutputProtocol {
    
    // MARK: - InformationMoviesInteractorOutputProtocol functions
    func pushSimilarMoviesData(similarMoviesData: [Movie]) {
        self.similarMovies = similarMoviesData
        self.view?.reloadCollectionViewData()
    }
    
    func pushInformationMovieData(movieData: InformationMovie) {
        if let view = view {
            view.catchResponse(withMessage: nil)
            router?.goToInformationMovie(informationMovieData: movieData, view: view)
        }
    }
    
    func catchResponse(withMessage: String) {
        view?.catchResponse(withMessage: withMessage)
    }
}
