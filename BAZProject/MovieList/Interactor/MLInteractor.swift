//
//  MLInteractor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import Foundation

final class MLInteractor {
    let provider: MLProviderProtocol
    weak var output: MLInteractorOutputProtocol?
    
    init(provider: MLProviderProtocol) {
        self.provider = provider
    }
}

extension MLInteractor: MLInteractorInputProtocol {
    /**
     Call the output method to send the title for the view
     */
    func fetchViewTitle() {
        self.output?.set(title: provider.viewTitle)
    }
    
    /**
     Calls interactor output methods after get the movies from the provider methods.
     - Parameters:
        - data: a Movies List object
     */
    func updateMovies(of data: MoviesList) {
        self.provider.update(moviesData: data) { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.didFindMovies(data)
            case .failure(let error):
                self?.output?.didFind(error: error)
            }
        }
    }
}

