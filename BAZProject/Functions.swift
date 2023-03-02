//
//  Functions.swift
//  BAZProject
//
//  Created by Mario Arceo on 17/02/23.
//
import UIKit

/**
 This Function push the MovieDetails View
 
 # Example #
 ```
    getMovieDetails(view: myView, movie: myMovie, movieImage: myImageMovie)
 ```
 
 - Parameters:
    - view: The Actual View.
    - movie: The Movie to show Details.
    - movieImage: The Image from the Movie.
 
 # Notes: #
 1. Push the new view in navigationController
 */
func getMovieDetails(view: UIViewController, movie: Movie, movieImage: UIImage) {
    
    let storyboard = UIStoryboard(name: storyboards.details.rawValue, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewControllers.details.rawValue) as? MovieDetailsViewController ?? MovieDetailsViewController()
    viewController.myMovie = movie
    viewController.myImage = movieImage
    view.navigationController?.pushViewController(viewController, animated: true)
    
}

/**
 This Function convert an Array of Genres into a String ready to show
 
 # Example #
 ```
    getGenres(genres: myMovie.genresArray)
 ```
 
 - Parameters:
    - genres: [genres].
 - Returns: A list of Genres -> String
 */
func getGenres(genres: [genres]) -> String {
    var genresString = ""
    for genre in genres {
        genresString += "\(genre) "
    }
    
    return genresString.replacingOccurrences(of: "_", with: "-")
}
