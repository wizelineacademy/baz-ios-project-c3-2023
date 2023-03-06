//
//  PopularRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class PopularRemoteDataManager:PopularRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    private let popularURL = MovieRequest.getURL(endpoint: .popularMovies)
    weak var remoteRequestHandler: PopularRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let PopularURL = popularURL else { return }
        service.get(PopularURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
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
