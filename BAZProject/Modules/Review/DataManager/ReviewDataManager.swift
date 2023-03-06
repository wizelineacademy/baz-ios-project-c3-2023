//  ReviewDataManager.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ReviewDataManager {
    weak var interactor: ReviewDataManagerOutputProtocol?
    let providerNetworking: NetworkingProviderProtocol

    init(providerNetworking: NetworkingProviderProtocol) {
        self.providerNetworking = providerNetworking
    }
}

extension ReviewDataManager: ReviewDataManagerInputProtocol {

    typealias ResponseProvider = Result<ReviewResponse, Error>

    func requestReview(_ urlString: String) {
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(let data):
                self?.interactor?.handleGetReview(data.results ?? [])
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
}
