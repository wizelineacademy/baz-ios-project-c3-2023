//
//  DetailMovieRecommendationInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieRecommendationInteractor: DetailMovieRecommendationInteractorInputProtocol {
    
    var presenter: DetailMovieRecommendationInteractorOutputProtocol?
    var remoteDataManager: DetailMovieRecommendationRemoteDataManagerInputProtocol?
    
    func getRecommendation(idMovie: Int) {
        remoteDataManager?.getRecommendation(idMovie: idMovie)
    }
}

extension DetailMovieRecommendationInteractor: DetailMovieRecommendationRemoteDataManagerOutputProtocol {
    func pushNotRecommendation() {
        presenter?.pushNotRecommendation()
    }
    
    func pushRecommendation(recommendation: [Movie]) {
        presenter?.pushRecommendation(recommendation: recommendation)
    }
}
