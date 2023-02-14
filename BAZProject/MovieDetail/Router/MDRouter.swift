//
//  MDRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MDRouter {
    
    /**
     Create each needed component of the movie detail view controller and connect its references
     - Parameters:
        - movie: a Movie object
     - Returns: a view controller with the detail of the received movie object
     */
    static func getEntry(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        let interactor = MDInteractor(movie: movie)
        let presenter = MDPresenter(
            view: view,
            interactor: interactor
        )
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
