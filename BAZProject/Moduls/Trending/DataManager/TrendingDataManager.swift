//
//  TrendingDataManager.swift
//  BAZProject
//
//  Created by 1058889 on 27/01/23.
//

import UIKit

final class TrendingDataManager {
    weak var interactor: TrendingDataManagerOutputProtocol?
    weak var providerNetworking: NetworkingProviderProtocol?
    
    init(providerNetworking: NetworkingProviderProtocol?) {
        self.providerNetworking = providerNetworking
    }
}

extension TrendingDataManager: TrendingDataManagerInputProtocol {

    func requestTrendingMedia(_ urlString: String) {
        
        providerNetworking?.sendRequest(
            requestType: RequestType(strUrl: urlString, method: .GET)
        ) { [weak self] success, data in
            
            guard let self = self else { return }
    
            DispatchQueue.main.async {
                if success, let data = data {
                    do {
                        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                        self.interactor?.handleGetTrendingMedia(response.results ?? [])
                    } catch {
                        self.interactor?.handleErrorService()
                    }
                } else {
                    self.interactor?.handleErrorService()
                }
            }
        }
    }
    
}
