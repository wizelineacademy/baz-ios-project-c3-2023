//
//  TrendingDataManager.swift
//  BAZProject
//
//  Created by 1058889 on 27/01/23.
//

import UIKit

final class TrendingDataManager {
    weak var interactor: TrendingDataManagerOutputProtocol?
    let providerNetworking: NetworkingProviderProtocol

    init(providerNetworking: NetworkingProviderProtocol) {
        self.providerNetworking = providerNetworking
    }
}

extension TrendingDataManager: TrendingDataManagerInputProtocol {

    typealias ResponseProvider = Result<MovieResponse, Error>

    func requestTrendingMedia(_ urlString: String) {
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(let movie):
                self?.interactor?.handleGetTrendingMedia(movie.results ?? [])
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
}
