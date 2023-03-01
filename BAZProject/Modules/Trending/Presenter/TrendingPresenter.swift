//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

class TrendingPresenter {
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?

    var data: [TrendingModel] = []
    var isFetchInProgress: Bool = false
    var totalDataCount: Int?
    var currentPage: Int?
    var totalPages: Int?
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func willFetchTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        interactor?.fetchTrendingMedia(mediaType: mediaType, timeWindow: timeWindow)
    }

    func willFetchSearchMovie(by keyword: String) {
        interactor?.fetchSearchMovie(with: keyword)
    }

    func willShowAlertLoading(with alertType: ErrorType) {
        router?.showAlertLoading(with: alertType)
    }

    func willHideAlertLoading() {
        router?.hideAlertLoading()
    }

    func willShowDetail(of detailType: DetailType) {
        router?.showDetail(of: detailType)
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func onReceivedTrendingMedia(result: MovieResponse) {
        view?.setErrorGettingData(false)
        currentPage = result.page
        result.results?.forEach({ movie in
            data.append(TrendingModel(with: movie))
        })
        totalDataCount = data.count
        view?.updateView()
        view?.stopLoading()
    }

    func onReceivedSearchMovie(data: MovieResponse) {
        view?.setErrorGettingData(false)
        self.data = []
        currentPage = data.page
        data.results?.forEach({ movie in
            self.data.append(TrendingModel(with: movie))
        })
        totalDataCount = self.data.count
        view?.updateView()
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
