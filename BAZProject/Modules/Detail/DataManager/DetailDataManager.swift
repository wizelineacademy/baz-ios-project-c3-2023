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
    func requestMedia(_ urlString: String) {
        typealias ResponseProvider = Result<MovieDetailResult, Error>
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

    func requestReview(_ urlString: String) {
        typealias ResponseProvider = Result<ReviewResponse, Error>
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

    func requestSimilarMovie(_ urlString: String) {
        typealias ResponseProvider = Result<SimilarMovieModelResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(let data):
                self?.interactor?.handleGetSimilarMovie(data.results ?? [])
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }

    func requestMovieRecomendation(_ urlString: String) {
        typealias ResponseProvider = Result<RecomendationMovieModelResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            switch result {
            case .success(let data):
                self?.interactor?.handleGetMovieRecomendation(data.results ?? [])
            case .failure(let error):
                self?.interactor?.handleErrorService(error)
            }
        }
    }
}
