//
//  TrendingRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import Foundation

//MARK: MovieAPI cambio a ser TrendingRemoteDataManager en conjunto con ServiceAPI
class TrendingRemoteDataManager: TrendingRemoteDataManagerInputProtocol {
    
    private let service: ServiceProtocol
    private let trendingURL = MovieRequest.getURL(endpoint: .trendingMovies)
    weak var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol?

    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let trendingURL = trendingURL else { return }
        service.get(trendingURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.moviesFetched(response.results ?? [])
                break
            case .failure(_):
//                self?.remoteRequestHandler?.funcionparagestionarerrores(error)
                break
            }
            
        }
    }

}

struct Response<T: Codable>: Codable {
    var page: Int?
    var results: T?
    var total_pages: Int?
    var total_results: Int?
}
