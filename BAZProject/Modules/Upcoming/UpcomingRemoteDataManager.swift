//
//  UpcomingRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import Foundation

class UpcomingRemoteDataManager:UpcomingRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    private let upcomingURL = MovieRequest.getURL(endpoint: .upcomingMovies)
    weak var remoteRequestHandler: UpcomingRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let UpcomingURL = upcomingURL else { return }
        service.get(UpcomingURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
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
