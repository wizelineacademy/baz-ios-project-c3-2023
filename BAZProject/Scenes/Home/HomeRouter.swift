//
//  HomeRouter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol HomeRoutingLogic {
    func routeToMoviesBySection(section: fetchMoviesTypes, movies: [MovieSearch])
}

class HomeRouter: HomeRoutingLogic {
        
    // MARK: Properties
    weak var viewController: HomeViewController?
    
    func routeToMoviesBySection(section: fetchMoviesTypes, movies: [MovieSearch]) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MoviesBySectionViewController") as! MoviesBySectionViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMoviesBySection(source: (section: section, movies: movies), destination: &destinationDS)
        navigateToMoviesBySection(source: viewController!, destination: destinationVC)
    }
    
    private func passDataToMoviesBySection(source: (section: fetchMoviesTypes, movies: [MovieSearch]), destination: inout MoviesBySectionDataStore) {
        destination.section = source.section
        destination.movies = source.movies
    }
    
    private func navigateToMoviesBySection(source: HomeViewController, destination: MoviesBySectionViewController) {
        viewController?.show(destination, sender: nil)
    }
}
