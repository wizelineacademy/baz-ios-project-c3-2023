//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    // TODO: create functions to manage business logic
}

protocol MovieDetailsDataStore: AnyObject {
    var movie: MovieSearch? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    // MARK: Properties VIP
    var presenter: MovieDetailsPresentationLogic?
    
    var movie: MovieSearch?
    
}
