//
//  DetailMovieCastInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieCastInteractor: DetailMovieCastInteractorInputProtocol {
    
    weak var presenter: DetailMovieCastInteractorOutputProtocol?
    var remoteDataManager: DetailMovieCastRemoteDataManagerInputProtocol?
    
    func getCast(idMovie: Int) {
        remoteDataManager?.getCast(idMovie: idMovie)
    }
    
    
}

extension DetailMovieCastInteractor: DetailMovieCastRemoteDataManagerOutputProtocol {
    
    func pushCast(cast: [Cast]) {
        presenter?.pushCast(cast: cast)
    }
    
    
}
