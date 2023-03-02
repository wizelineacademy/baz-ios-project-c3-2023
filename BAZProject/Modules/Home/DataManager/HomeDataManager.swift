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
    func requestMovieTopRated(_ urlString: String) {
        typealias ResponseProvider = Result<MovieTopRatedResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.interactor?.handleGetMovieTopRated(data.results ?? [])
            case .failure(let error):
                self.interactor?.handleErrorService(error)
            }
        }
    }

    func requestNowPlaying(_ urlString: String) {
        typealias ResponseProviderNowPlaying = Result<NowPlayingResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProviderNowPlaying) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.interactor?.handleGetNowPlaying(data.results ?? [])
            case .failure(let error):
                self.interactor?.handleErrorService(error)
            }
        }
    }

    func requestPopularMovies(_ urlString: String) {
        typealias ResponseProviderNowPlaying = Result<PoularMoviesModelResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProviderNowPlaying) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.interactor?.handleGetPopularMovies(data.results ?? [])
            case .failure(let error):
                self.interactor?.handleErrorService(error)
            }
        }
    }

    func requestUpcomingMovies(_ urlString: String) {
        typealias ResponseProviderNowPlaying = Result<UpcomingModelResponse, Error>
        let request: URLRequest = RequestType(strUrl: urlString, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProviderNowPlaying) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.interactor?.handleGetUpcomingMovies(data.results ?? [])
            case .failure(let error):
                self.interactor?.handleErrorService(error)
            }
        }
    }
}
