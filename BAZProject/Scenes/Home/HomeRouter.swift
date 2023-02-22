//
//  HomeRouter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

@objc protocol HomeRoutingLogic {
    func routeToMoviesBySection()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {
        
    // MARK: Properties
    var dataStore: HomeDataStore?
    weak var viewController: HomeViewController?
    
    func routeToMoviesBySection() {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MoviesBySectionViewController") as! MoviesBySectionViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMoviesBySection(source: dataStore!, destination: &destinationDS)
        navigateToMoviesBySection(source: viewController!, destination: destinationVC)
    }
    
    private func passDataToMoviesBySection(source: HomeDataStore, destination: inout MoviesBySectionDataStore) {
        destination.section = source.section
        destination.movies = source.movies
    }
    
    private func navigateToMoviesBySection(source: HomeViewController, destination: MoviesBySectionViewController) {
        viewController?.show(destination, sender: nil)
    }
}
