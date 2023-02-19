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
    func fetchHome() {
        // TODO: add string url
        let urlString: String = "https://google.com"
        dataManager?.requestHome(urlString)
    }
}

extension HomeInteractor: HomeDataManagerOutputProtocol {
    func handleGetHome(_ result: HomeResult) {
        presenter?.onReceivedHome(result)
    }
    
    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
