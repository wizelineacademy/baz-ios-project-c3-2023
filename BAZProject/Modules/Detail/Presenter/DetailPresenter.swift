//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import Foundation

final class DetailPresenter {
    var router: DetailRouterProtocol?
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
}

extension DetailPresenter: DetailPresenterProtocol {
    func willFetchMedia(detailType: DetailType) {
        interactor?.fetchMedia(detailType: detailType)
    }

    func willFetchReview(of idMovie: String) {
        interactor?.fetchReview(of: idMovie)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func onReceivedMedia(result: MovieDetailResult) {
        view?.setErrorGettingData(false)
        view?.updateView(data: result)
        view?.stopLoading()
    }

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

        errorModel.setTitleNavBar(.trendingTitle)
        view?.setErrorGettingData(true)
        router?.showViewError(errorModel)
    }
}
