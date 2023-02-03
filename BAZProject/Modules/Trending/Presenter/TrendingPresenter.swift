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
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        interactor?.getTrendingMedia(mediaType: mediaType, timeWindow: timeWindow)
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func getTrendingMedia(result: [MovieResult]) {
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
