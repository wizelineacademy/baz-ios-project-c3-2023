//
//  TrendingViewInteractor.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

class TrendingInteractor {
    weak var presenter: TrendingInteractorOutputProtocol?
    var dataManager: TrendingDataManagerInputProtocol?
}

extension TrendingInteractor: TrendingInteractorInputProtocol {
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        let endPoint: String = "/trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        let strUrl: String = endPoint.getStrUrlTheMovieDb()
        dataManager?.requestTrendingMedia(strUrl)
    }
}

extension TrendingInteractor: TrendingDataManagerOutputProtocol {
    func handleGetTrendingMedia(_ result: [MovieResult]) {
        presenter?.getTrendingMedia(result: result)
    }
    
    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
