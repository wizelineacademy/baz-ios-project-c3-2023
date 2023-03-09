//
//  MDInteractor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation
/** MD means Movie Detail */
final class MDInteractor {
    weak var output: MDInteractorOutputProtocol?
    private let provider: MovieDetailProviderProtocol
    
    init(provider: MovieDetailProviderProtocol) {
        self.provider = provider
    }
}

extension MDInteractor: MDInteractorInputProtocol {
    
    /// Call the interactor output method to return the given title by its provider
    func fetchTitle() {
        let title = self.provider.getTitle()
        self.output?.setTitleForView(title)
    }
    
    /// Call the interactor output method to return the given cell classes by its provider
    func fetchCellClasses() {
        let cellClasses = self.provider.getCellClasses()
        self.output?.setupCells(cellClasses)
    }
    
    /** Call the interactor output method to present the received movie and post a notification with the given movie */
    func fetchMovieDetail() {
        let movieInfo: [String: Any] = [StoredMovies.movieNotificationKey: provider.movie]
        NotificationCenter.default.post(name: .seenMovie, object: nil, userInfo: movieInfo)
        self.provider.fetchMoreDetails { [weak self] result in
            switch result {
            case .success(let details):
                self?.output?.didFind(details)
            case .failure(let error):
                self?.output?.didFind(error)
            }
        }
    }
}
