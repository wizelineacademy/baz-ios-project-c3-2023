//
//  Functions.swift
//  BAZProject
//
//  Created by Mario Arceo on 17/02/23.
//
import UIKit

func getMovieDetails(view: UIViewController, movie: Movie, movieImage: UIImage) {
    
    let storyboard = UIStoryboard(name: storyboards.details.rawValue, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewControllers.details.rawValue) as? MovieDetailsViewController ?? MovieDetailsViewController()
    viewController.myMovie = movie
    viewController.myImage = movieImage
    view.navigationController?.pushViewController(viewController, animated: true)
    
}
