//
//  MovieAPIManager.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 09/03/23.
//
import UIKit

/**
 A class responsible for managing requests to the `MovieAPI` and passing the results to a delegate.
 */
class MovieAPIManager {
    /// The instance of the `MovieAPI` used for making requests.
    private let movieAPI = MovieAPI()
    /// The delegate that receives the results of the requests
    ///
    ///- Note: The delegate is set to `nil` by default, and should be set to a non-`nil` value to receive callbacks from the `MovieAPIManager`.
    weak var delegate: MovieAPIManagerDelegate? {
        didSet{
            movieAPI.delegate = delegate
        }
    }
    /// Requests a list of trending movies from the `MovieAPI`.
    func getTrendingMovies() {
        movieAPI.getTrendingMovies()
    }
    ///Requests a list of movies currently playing in theaters `.
    func getNowPlayingMovies() {
        movieAPI.getNowPlayingMovies()
    }
    /// Requests a list of popular movies
    func getPopularMovies() {
        movieAPI.getPopularMovies()
    }
    /// Requests a list of upcoming movies
    func getUpcomingMovies() {
        movieAPI.getUpcomingMovies()
    }
    ///Requests a list of top rated movies
    func getRatedMovies() {
        movieAPI.getRatedMovies()
    }
    /// Requests a list of movies similar to a given movie.
    ///  - Parameters:
    ///  - idMovie: The ID of the movie for which to retrieve similar movies.
    func getSimilarMovies(idMovie: Int) {
        movieAPI.getSimilarMovies(idMovie: idMovie)
    }
    ///Requests a list of movies recommended based on a given movie from the `MovieAPI`.
    ///- Parameters:
    ///- idMovie: The ID of the movie for which to retrieve recommended movies.
    func getRecommendationsMovies(idMovie: Int) {
        movieAPI.getRecommendationsMovies(idMovie: idMovie)
    }
    ///Fetches the cast of a movie by its ID.
    ///- Parameter idMovie: The ID of the movie to fetch the cast for.
    func getMovieCast(idMovie: Int) {
        movieAPI.getMovieCast(idMovie: idMovie)
    }
    ///Fetches the reviews of a movie by its ID.
    ///- Parameter idMovie: The ID of the movie to fetch the reviews for.
    func getReviewsMovies(idMovie: Int) {
        movieAPI.getReviewsMovies(idMovie: idMovie)
    }
    /// Fetches the image of a movie by its profile path.
    /// - Parameter profilePath: The profile path of the movie to fetch the image for.
    /// - Parameter completion: A closure to be called once the image has been fetched. It takes an optional `UIImage` as its parameter.
    func getImageMovie(profilePath: String?,completion: @escaping (UIImage?) -> ()) {
        guard let path = profilePath else {
            return
        }
        let url = "https://image.tmdb.org/t/p/w500\(path)"
        movieAPI.getImageMovie(urlString: url, completion: completion)
    }
    /// Search for movies based on the specified query.
    /// - Parameter query: The search query to use.
    /// - Parameter completion: A closure that will be called when the search is complete.
    func searchMovies(query: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        movieAPI.searchMovies(query: query, completion: completion)
    }
}
