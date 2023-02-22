//
//  MoviesBySectionRouter.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

protocol MoviesBySectionRoutingLogic: AnyObject {
    
}

protocol MoviesBySectionDataPassing {
    var dataStore: MoviesBySectionDataStore? { get }
}

class MoviesBySectionRouter: MoviesBySectionRoutingLogic, MoviesBySectionDataPassing {
    
    weak var viewController: MoviesBySectionViewController?
    var dataStore: MoviesBySectionDataStore?
}
