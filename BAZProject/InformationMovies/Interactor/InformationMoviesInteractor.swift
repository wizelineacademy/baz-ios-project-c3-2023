//
//  InformationMoviesInteractor.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

class InformationMoviesInteractor: InformationMoviesInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: InformationMoviesInteractorOutputProtocol?
    var remoteDatamanager: InformationMoviesRemoteDataManagerInputProtocol?
    
    // MARK: - InformationMoviesInteractorInputProtocol functions
    func getMovieSimilar(idMovie: Int) {
        remoteDatamanager?.getMovieSimilar(idMovie: idMovie)
    }
    
    func getInformationMovie(idMovie: Int) {
        remoteDatamanager?.getInformationMovie(idMovie: idMovie)
    }
}

// MARK: - InformationMoviesRemoteDataManagerOutputProtocol
extension InformationMoviesInteractor: InformationMoviesRemoteDataManagerOutputProtocol {
    
    // MARK: - InformationMoviesRemoteDataManagerOutputProtocol functions
    func pushSimilarMoviesData(similarMoviesData: [Movie]) {
        presenter?.pushSimilarMoviesData(similarMoviesData: similarMoviesData)
    }
    
    func pushInformationMovieData(movieData: InformationMovie) {
        presenter?.pushInformationMovieData(movieData: movieData)
    }
    
    func catchResponse(withMessage: String) {
        presenter?.catchResponse(withMessage: withMessage)
    }
}
