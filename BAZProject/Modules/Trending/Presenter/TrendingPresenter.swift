//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

class TrendingPresenter {
    
    weak var view: TrendingProtocol?
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
        view?.updateView(data: result)
        view?.stopLoading()
    }
    
    func showViewError() {
        view?.showErrorView()
        view?.stopLoading()
    }
}
