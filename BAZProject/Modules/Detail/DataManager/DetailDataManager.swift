//
//  DetailDataManager.swift
//  BAZProject
//
//  Created by 1058889 on 15/02/23.
//

import Foundation

final class DetailDataManager {
    weak var interactor: DetailDataManagerOutputProtocol?
    let providerNetworking: NetworkingProviderProtocol

    init(providerNetworking: NetworkingProviderProtocol) {
        self.providerNetworking = providerNetworking
    }
}

extension DetailDataManager: DetailDataManagerInputProtocol {

    typealias ResponseProvider = Result<MovieDetailResult, Error>

    func requestMedia(_ urlString: String) {
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(var movie):
                movie.decrypt()
                self?.interactor?.handleGetMediaMovie(movie)
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
}
