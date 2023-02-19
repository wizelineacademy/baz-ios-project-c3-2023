//  HomePresenter.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class HomePresenter {
    // MARK: - Protocol properties
    var router: HomeRouterProtocol?
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    func willFetchHome() {
        interactor?.fetchHome()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func onReceivedHome(_ result: HomeResult) {
        view?.setErrorGettingData(false)
        view?.updateView(data: result)
        view?.stopLoading()
    }
    
    func showViewError(_ error: Error) {
        var errorModel: ErrorType
        if let fetchedError: ServiceError = error as? ServiceError {
             errorModel = ErrorType(serviceError: fetchedError)
        } else {
            errorModel = ErrorType(title: error.localizedDescription, message: "Error code: \(error._code) - \(error._domain)")
        }
        view?.setErrorGettingData(true)
        router?.showViewError(errorModel)
    }
}
