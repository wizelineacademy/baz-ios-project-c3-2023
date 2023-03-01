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

    func fetchSearchMovie(with keyword: String) {
        dataManager?.requestSearchMovie(Endpoint.searchMovie(byKeywork: keyword).urlString)
    }
}

extension TrendingInteractor: TrendingDataManagerOutputProtocol {
    func handleGetTrendingMedia(_ data: MovieResponse) {
        presenter?.onReceivedTrendingMedia(result: data)
    }

    func handleGetSearchMovie(_ data: MovieResponse) {
        presenter?.onReceivedSearchMovie(data: data)
    }

    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
