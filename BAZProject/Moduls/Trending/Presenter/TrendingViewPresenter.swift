//
//  TrendingViewPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

typealias presenterProtocols = TrendingPresenterProtocol & TrendingViewInteractorOutputProtocol
class TrendingViewPresenter: presenterProtocols {
    
    var router: TrendingRouterProtocol?
    var view: TrendingViewProtocol?
    var interactor: TrendingViewInteractorInputProtocol?
    
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        interactor?.getTrendingMedia(mediaType: mediaType, timeWindow: timeWindow)
    }
    
    func getTrendingMedia(success: Bool, result: [MovieResult]?) {
        if success, let data = result {
            view?.updateView(data: data)
        } else {
            view?.showErrorView()
        }
        view?.stopLoading()
    }
}
