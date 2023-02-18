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
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?

    func getDetails(idMovie: Int?) {
        remoteDatamanager?.getDetails(idMovie: idMovie)
    }
}

extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {

    func pushDetailMovie(detailMovie: DetailMovie) {
        presenter?.pushDetailMovie(detailMovie: detailMovie)
    }
}
