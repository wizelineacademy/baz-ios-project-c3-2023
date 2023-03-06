//
//  MovieDetailsRouter.swift
//  BAZProject
//
//  Created by 1034209 on 23/02/23.
//

import Foundation

protocol MovieDetailsRoutingLogic: AnyObject {
    func routeToMoviesBySection(section: fetchMoviesTypes, movies: [MovieSearch])
    func routeToMovieDetails(movie: MovieSearch)
}

protocol MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
    
    func routeToMoviesBySection(section: fetchMoviesTypes, movies: [MovieSearch]) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MoviesBySectionViewController") as! MoviesBySectionViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMoviesBySection(source: (section: section, movies: movies), destination: &destinationDS)
        navigateToMoviesBySection(source: viewController!, destination: destinationVC)
    }
    
    func routeToMovieDetails(movie: MovieSearch) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetails(source: movie, destination: &destinationDS)
        navigateToMovieDetails(source: viewController!, destination: destinationVC)
    }
    
    private func passDataToMovieDetails(source: MovieSearch, destination: inout MovieDetailsDataStore) {
        destination.movie = source
    }
    
    private func navigateToMovieDetails(source: MovieDetailsViewController, destination: MovieDetailsViewController) {
        source.show(destination, sender: nil)
    }
    
    private func passDataToMoviesBySection(source: (section: fetchMoviesTypes, movies: [MovieSearch]), destination: inout MoviesBySectionDataStore) {
        destination.section = source.section
        destination.movies = source.movies
    }
    
    private func navigateToMoviesBySection(source: MovieDetailsViewController, destination: MoviesBySectionViewController) {
        source.show(destination, sender: nil)
    }
}
