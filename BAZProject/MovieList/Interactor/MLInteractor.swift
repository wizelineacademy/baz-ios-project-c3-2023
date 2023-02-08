//
//  MLInteractor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import Foundation

final class MLInteractor {
    let provider: MLProviderProtocol
    weak var output: MLOutputProtocol?
    
    init(provider: MLProviderProtocol) {
        self.provider = provider
    }
}

extension MLInteractor: MLInteractorProtocol {
    func fetchData() {
        self.output?.set(title: provider.viewTitle)
        self.provider.getMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.output?.didFind(movies: movies)
            case .failure(let error):
                self?.output?.didFind(error: error)
            }
        }
    }
    
    func check(movie: Movie) {
        let viewController = self.provider.getNextViewController(for: movie)
        self.output?.goNext(viewController)
    }
}

