//
//  MDInteractor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation

final class MDInteractor {
    weak var output: MDOutputProtocol?
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension MDInteractor: MDInteractorProtocol {
    func fetchData() {
        self.output?.find(movie)
    }
}
