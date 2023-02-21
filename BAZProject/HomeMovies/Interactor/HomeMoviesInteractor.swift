//
//  HomeMoviesInteractor.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class HomeMoviesInteractor: HomeMoviesInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: HomeMoviesInteractorOutputProtocol?
    var remoteDatamanager: HomeMoviesRemoteDataManagerInputProtocol?

    // MARK: - HomeMoviesInteractorInputProtocol functions
    func getMovies(categoryMovieType: MovieCategory) {
        remoteDatamanager?.getMovies(categoryMovieType: categoryMovieType)
    }
    
    func getSearchedMovies(searchTerm: String) {
        remoteDatamanager?.getSearchedMovies(searchTerm: searchTerm)
    }
    
    func getInformationMovie(idMovie: Int) {
        remoteDatamanager?.getInformationMovie(idMovie: idMovie)
    }
}

// MARK: - HomeMoviesRemoteDataManagerOutputProtocol
extension HomeMoviesInteractor: HomeMoviesRemoteDataManagerOutputProtocol {
    
    // MARK: - HomeMoviesRemoteDataManagerOutputProtocol functions
    func pushSearchedMoviesData(moviesData: [Movie]) {
        presenter?.pushSearchedMoviesData(moviesData: moviesData)
    }
    
    func pushMoviesData(moviesData: [Movie]) {
        presenter?.pushMoviesData(moviesData: moviesData)
    }
    
    func pushInformationMovieData(movieData: InformationMovie) {
        presenter?.pushInformationMovieData(movieData: movieData)
    }
    
    func catchResponse(withMessage: String) {
        presenter?.catchResponse(withMessage: withMessage)
    }
}
