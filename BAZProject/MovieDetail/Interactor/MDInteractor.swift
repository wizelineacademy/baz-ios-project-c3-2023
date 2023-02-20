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
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension MDInteractor: MDInteractorInputProtocol {
    /** Call the interactor output method to present the received movie */
    func fetchMovieDetail() {
        self.output?.present(movie)
    }
}
