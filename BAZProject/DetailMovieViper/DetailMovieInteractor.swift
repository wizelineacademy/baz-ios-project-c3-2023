//
//  DetailMovieInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation

class DetailMovieInteractor: DetailMovieInteractorInputProtocol {
  
    // MARK: Properties
    weak var presenter: DetailMovieInteractorOutputProtocol?
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?

    func getDetails(idMovie: Int?) {
        remoteDatamanager?.getDetails(idMovie: idMovie)
    }
    
    func getCast(idMovie: Int?) {
        remoteDatamanager?.getCast(idMovie: idMovie)
    }
    
    func getReviews(idMovie: Int?) {
        remoteDatamanager?.getReviews(idMovie: idMovie)
    }
    
    func getSimilar(idMovie: Int?) {
        remoteDatamanager?.getSimilar(idMovie: idMovie)
    }
    
    func getRecommendations(idMovie: Int?) {
        remoteDatamanager?.getRecommendations(idMovie: idMovie)
    }
}

extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {
 
    func pushDetailMovie(detailMovie: DetailMovie) {
        presenter?.pushDetailMovie(detailMovie: detailMovie)
    }
    
    func pushCast(cast: [Cast]) {
        presenter?.pushCast(cast: cast)
    }
    
    func pushNotCast() {
        presenter?.pushNotCast()
    }
    
    func pushReviews(reviews: [Reviews]) {
        presenter?.pushReviews(reviews: reviews)
    }
    
    func pushNotRewiews() {
        presenter?.pushNotRewiews()
    }
    
    func pushSimilar(similar: [Movie]) {
        presenter?.pushSimilar(similar: similar)
    }
    
    func pushNotSimilar() {
        presenter?.pushNotSimilar()
    }
    
    func pushRecommendations(recommendations: [Movie]) {
        presenter?.pushRecommendations(recommendations: recommendations)
    }
    
    func pushNotRecommentations() {
        presenter?.pushNotRecommentations()
    }
    
    
}
