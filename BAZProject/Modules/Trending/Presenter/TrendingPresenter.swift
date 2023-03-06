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
    var currentPage: Int = LocalizedConstants.trendingFirstPage
    var totalPages: Int?
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func getCurrentPage() -> Int {
        return currentPage
    }

    func getTotalPages() -> Int {
        return totalPages ?? .zero
    }

    func resetCurrentPages() {
        currentPage = LocalizedConstants.trendingFirstPage
    }

    func resetData() {
        data = []
        totalPages = .zero
        totalDataCount = .zero
    }

    func willFetchTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        interactor?.fetchTrendingMedia(mediaType: mediaType, timeWindow: timeWindow, page: currentPage)
    }

    func willFetchNextTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        currentPage += 1
        if currentPage > totalPages ?? currentPage { return }
        interactor?.fetchNextTrendingMedia(mediaType: mediaType, timeWindow: timeWindow, page: currentPage)
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

    func willShowDetail(of idMovie: String) {
        router?.showDetail(of: idMovie)
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func onReceivedTrendingMedia(result: MovieResponse) {
        view?.setErrorGettingData(false)
        self.data = []
        currentPage = result.page ?? currentPage
        totalPages = result.totalPages
        result.results?.forEach({ movie in
            data.append(TrendingModel(with: movie))
        })
        totalDataCount = data.count
        view?.updateView()
        view?.stopLoading()
    }

    func onReceivedNextTrendingMedia(result: MovieResponse) {
        view?.setErrorGettingData(false)
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
        currentPage = data.page ?? currentPage
        totalPages = data.totalPages
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
