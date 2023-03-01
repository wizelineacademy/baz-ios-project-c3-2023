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

    private var loading: Bool = false
    private var errorGetData: Bool = false

    // MARK: - Private methods
    private func stopLoading() {
        errorGetData = false
        loading = false
        view?.stopLoading()
    }

    private func setLoading() {
        loading = true
        errorGetData = false
    }

    private func getErrorType(from error: Error) -> ErrorType {
        var errorModel: ErrorType
        if let fetchedError: ServiceError = error as? ServiceError {
            errorModel = ErrorType(serviceError: fetchedError)
        } else {
            errorModel = ErrorType(title: error.localizedDescription,
                                   message: "Error code: \(error._code) - \(error._domain)")
        }

        errorModel.setTitleNavBar(.trendingTitle)
        return errorModel
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func isLoading() -> Bool {
        loading
    }

    func errorGettingData() -> Bool {
        return errorGetData
    }

    func willFetchMedia(detailType: DetailType) {
        setLoading()
        interactor?.fetchMedia(detailType: detailType)
    }

    func willFetchReview(of idMovie: String) {
        setLoading()
        interactor?.fetchReview(of: idMovie)
    }

    func willFetchSimilarMovie(of idMovie: String) {
        interactor?.fetchSimilarMovie(of: idMovie)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func onReceivedMedia(result: MovieDetailResult) {
        view?.updateView(data: result)
        stopLoading()
    }

    func onReceivedReview(_ result: [ReviewResult]) {
        view?.updateView(data: result)
        stopLoading()
    }

    func onReceivedReview(_ result: [SimilarMovieModelResult]) {
        view?.updateView(data: result)
        stopLoading()
    }

    func showViewError(_ error: Error) {
        if errorGetData { return }
        errorGetData = true
        router?.showViewError(getErrorType(from: error))
    }
}
