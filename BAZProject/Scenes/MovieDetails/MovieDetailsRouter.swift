//
//  MovieDetailsRouter.swift
//  BAZProject
//
//  Created by 1034209 on 23/02/23.
//

import Foundation

protocol MovieDetailsRoutingLogic: AnyObject {
    
}

protocol MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
}
