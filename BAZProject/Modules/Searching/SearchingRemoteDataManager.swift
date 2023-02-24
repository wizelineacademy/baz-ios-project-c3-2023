//
//  SearchingRemoteDataManager.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

class SearchingRemoteDataManager: SearchingRemoteDataManagerInputProtocol {
    
    
    private var service: ServiceProtocol
    weak var remoteRequestHandler: SearchingRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchSearchResults(with query: String) {
        guard let topRatedURL = MovieRequest.searchMovie(search: query) else { return }
        service.get(topRatedURL) { [weak self] (result: Result<Response<[SearchResult]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.searchResultsFecthed(searchResults: response.results ?? [])
                break
            case .failure(_):
                //TODO: Implement error handler
                break
            }
        }
    }
}
