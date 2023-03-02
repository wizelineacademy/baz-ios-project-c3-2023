//
//  NowPlayingRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class NowPlayingRemoteDataManager:NowPlayingRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    private let nowPlayingURL = MovieRequest.getURL(endpoint: .nowPlayingMovies)
    weak var remoteRequestHandler: NowPlayingRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let NowPlayingURL = nowPlayingURL else { return }
        service.get(NowPlayingURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.moviesFetched(response.results ?? [])
                break
            case .failure(_):
                //TODO: Implement error handler
                break
            }
        }
    }
}
