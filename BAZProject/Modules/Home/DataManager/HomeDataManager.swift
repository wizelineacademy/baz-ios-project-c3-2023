//  HomeDataManager.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class HomeDataManager {
    weak var interactor: HomeDataManagerOutputProtocol?
    let providerNetworking: NetworkingProviderProtocol
    
    init(providerNetworking: NetworkingProviderProtocol) {
        self.providerNetworking = providerNetworking
    }
}

extension HomeDataManager: HomeDataManagerInputProtocol {

    typealias ResponseProvider = Result<HomeResult, Error>

    func requestHome(_ urlString: String) {
        providerNetworking.sendRequest(RequestType(strUrl: urlString, method: .GET).getRequest()) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(let data):
                self?.interactor?.handleGetHome(data)
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
}
