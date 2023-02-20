//  HomeInteractor.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class HomeInteractor {
    // MARK: - Protocol properties
    weak var presenter: HomeInteractorOutputProtocol?
    var dataManager: HomeDataManagerInputProtocol?
}

extension HomeInteractor: HomeInteractorInputProtocol {
    func fetchMovieTopRated() {
        dataManager?.requestMovieTopRated(Endpoint.topRated.urlString)
    }
}

extension HomeInteractor: HomeDataManagerOutputProtocol {    
    func handleGetMovieTopRated(_ result: [MovieTopRatedResult]) {
        presenter?.onReceivedMovieTopRated(result)
    }
    
    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
