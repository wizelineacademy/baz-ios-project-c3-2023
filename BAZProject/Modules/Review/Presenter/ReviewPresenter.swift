//  ReviewPresenter.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ReviewPresenter {
    // MARK: - Protocol properties
    var router: ReviewRouterProtocol?
    weak var view: ReviewViewProtocol?
    var interactor: ReviewInteractorInputProtocol?
}

extension ReviewPresenter: ReviewPresenterProtocol {
    func willFetchReview(of idMovie: String) {
        interactor?.fetchReview(of: idMovie)
    }
}

extension ReviewPresenter: ReviewInteractorOutputProtocol {
    func onReceivedReview(_ result: [ReviewResult]) {
        view?.setErrorGettingData(false)
        view?.updateView(data: result)
        view?.stopLoading()
    }

    func showViewError(_ error: Error) {
        var errorModel: ErrorType
        if let fetchedError: ServiceError = error as? ServiceError {
             errorModel = ErrorType(serviceError: fetchedError)
        } else {
            errorModel = ErrorType(title: error.localizedDescription,
                                   message: "Error code: \(error._code) - \(error._domain)")
        }
        view?.setErrorGettingData(true)
        router?.showViewError(errorModel)
    }
}
