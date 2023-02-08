//
//  TopRatedInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import Foundation

class TopRatedInteractor: TopRatedInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: TopRatedInteractorOutputProtocol?
    var localDatamanager: TopRatedLocalDataManagerInputProtocol?
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol?

}

extension TopRatedInteractor: TopRatedRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
