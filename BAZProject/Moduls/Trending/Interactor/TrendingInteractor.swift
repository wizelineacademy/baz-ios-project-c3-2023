//
//  TrendingViewInteractor.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

typealias TrendingInteractorProtocol = TrendingViewInteractorInputProtocol & TrendingViewInteractorOutputProtocol
class TrendingInteractor: TrendingInteractorProtocol {

    weak var presenter: TrendingViewInteractorOutputProtocol?
    var providerNetworking: NetworkingProviderProtocol = NetworkingProviderService.shared
    
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType) {
        
        let endPoint: String = "/trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        let strUrl: String = endPoint.getStrUrlTheMovieDb()
        
        providerNetworking.sendRequest(
            requestType: RequestType(strUrl: strUrl, method: .GET)
        ) { [weak self] success, data in
            guard let self = self else {
                self?.presenter?.getTrendingMedia(success: false, result: nil)
                return
            }
            DispatchQueue.main.async {
                var result: [MovieResult]?
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                        result = response.results
                    } catch {
                        result = nil
                    }
                }
                self.presenter?.getTrendingMedia(success: success, result: result)
                
//                self.presenter.sucess()
//                
//                self.presenter.fail()
//                dataManager -> 
            }
        }
    }
    
    func getTrendingMedia(success: Bool, result: [MovieResult]?) {
        presenter?.getTrendingMedia(success: success, result: result)
    }
}
