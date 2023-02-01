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

    func requestTrendingMedia(_ urlString: String) {
        
        providerNetworking.sendRequest(RequestType(strUrl: urlString, method: .GET).getRequest()) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movie):
                self?.interactor?.handleGetTrendingMedia(movie.results ?? [])
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
    
}
