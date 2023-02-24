//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    func loadView()
}

protocol MovieDetailsDataStore: AnyObject {
    var movie: MovieSearch? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    // MARK: Properties VIP
    var presenter: MovieDetailsPresentationLogic?
    var movie: MovieSearch?
    
    func loadView() {
        guard let movie = movie else {
            return 
        }
        let response = MovieDetails.LoadView.Response(movie: movie)
        presenter?.presentLoadView(response: response)
    }
}
