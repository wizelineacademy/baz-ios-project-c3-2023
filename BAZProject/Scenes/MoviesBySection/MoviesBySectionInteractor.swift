//
//  MoviesBySectionInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

protocol MoviesBySectionBusinessLogic: AnyObject {
    
}

protocol MoviesBySectionDataStore: AnyObject {
    var section: fetchMoviesTypes? { get set }
    var movies: [Movie]? { get set }
}

class MoviesBySectionInteractor: MoviesBySectionBusinessLogic, MoviesBySectionDataStore {
    
    var section: fetchMoviesTypes?
    var movies: [Movie]?
    var presenter: MoviesBySectionPresentationLogic?
}
