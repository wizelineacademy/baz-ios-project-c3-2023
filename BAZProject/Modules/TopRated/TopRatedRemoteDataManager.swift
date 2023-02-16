//
//  TopRatedRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import Foundation

class TopRatedRemoteDataManager:TopRatedRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    private let topRatedURL = MovieRequest.getURL(endpoint: .topRatedMovies)
    weak var remoteRequestHandler: TopRatedRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let topRatedURL = topRatedURL else { return }
        service.get(topRatedURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
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
