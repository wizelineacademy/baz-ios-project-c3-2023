//
//  DetailMovieSimilarInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieSimilarInteractor: DetailMovieSimilarInteractorInputProtocol {
    
    var presenter: DetailMovieSimilarInteractorOutputProtocol?
    var remoteDataManager: DetailMovieSimilarRemoteDataManagerInputProtocol?
    
    func getSimilar(idMovie: Int) {
        remoteDataManager?.getSimilar(idMovie: idMovie)
    }
    
    
}

extension DetailMovieSimilarInteractor: DetailMovieSimilarRemoteDataManagerOutputProtocol {
    func pushNotSimilar() {
        presenter?.pushNotSimilar()
    }
    
    func pushSimilar(similar: [Movie]) {
        presenter?.pushSimilar(similar: similar)
    }
}
