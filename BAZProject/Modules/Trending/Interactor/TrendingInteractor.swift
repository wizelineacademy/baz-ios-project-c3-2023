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
    func fetchTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        dataManager?.requestTrendingMedia(Endpoint.trending(mediaType: mediaType, timeWindow: timeWindow).urlString)
    }
}

extension TrendingInteractor: TrendingDataManagerOutputProtocol {
    func handleGetTrendingMedia(_ result: [MovieResult]) {
        presenter?.onReceivedTrendingMedia(result: result)
    }

    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
