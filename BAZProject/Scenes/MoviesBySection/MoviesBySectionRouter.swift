//
//  MoviesBySectionRouter.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

protocol MoviesBySectionRoutingLogic: AnyObject {
    func routeToMovieDetails(movie: MovieSearch)
}

protocol MoviesBySectionDataPassing {
    var dataStore: MoviesBySectionDataStore? { get }
}

class MoviesBySectionRouter: MoviesBySectionRoutingLogic, MoviesBySectionDataPassing {
    
    weak var viewController: MoviesBySectionViewController?
    var dataStore: MoviesBySectionDataStore?
    
    func routeToMovieDetails(movie: MovieSearch) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetails(source: movie, destination: &destinationDS)
        navigateToMovieDetails(source: viewController!, destination: destinationVC)
    }
    
    private func passDataToMovieDetails(source: MovieSearch, destination: inout MovieDetailsDataStore) {
        destination.movie = source
    }
    
    private func navigateToMovieDetails(source: MoviesBySectionViewController, destination: MovieDetailsViewController) {
        source.show(destination, sender: nil)
    }
}
