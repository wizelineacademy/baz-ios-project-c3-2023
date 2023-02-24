//
//  SearchMoviesRouter.swift
//  BAZProject
//
//  Created by 1034209 on 23/02/23.
//

import Foundation

protocol SearchMoviesRoutingLogic: AnyObject {
    func routeToMovieDetails(movie: MovieSearch)
}

class SearchMoviesRouter: SearchMoviesRoutingLogic {
    
    weak var viewController: SearchMoviesViewController?
    
    func routeToMovieDetails(movie: MovieSearch) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetails(source: movie, destination: &destinationDS)
        navigateToMovieDetails(source: viewController!, destination: destinationVC)
    }
    
    private func passDataToMovieDetails(source: MovieSearch, destination: inout MovieDetailsDataStore) {
        destination.movie = source
    }
    
    private func navigateToMovieDetails(source: SearchMoviesViewController, destination: MovieDetailsViewController) {
        source.show(destination, sender: nil)
    }
}
