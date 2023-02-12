//
//  MSInteractor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

final class MSInteractor {
    weak var output: MSInteractorOutputProtocol?
    private let provider: MSProviderProtocol
    
    init(provider: MSProviderProtocol) {
        self.provider = provider
    }
}

extension MSInteractor: MSInteractorInputProtocol {
    /** Gets the needed data from the provider and call the interactor output method to set the view with the received data */
    func fetchViewData() {
        let data = provider.getViewData()
        self.output?.setView(with: data)
    }
    
    /**
     Call the interactor output methods to return the received movies on success case, otherwise return an error
     - Parameters:
        - text: a string witch the search is performed with
     */
    func fetchMovies(by text: String?) {
        provider.getMovies(by: text) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.output?.didReceive(movies)
            case .failure(let error):
                self?.output?.didReceive(error)
            }
        }
    }
}
