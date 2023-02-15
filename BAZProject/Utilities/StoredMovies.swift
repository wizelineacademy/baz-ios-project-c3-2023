//
//  StoredMovies.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 14/02/23.
//

import Foundation

final class StoredMovies {
    
    static let movieNotificationKey: String = "movie"
    private static let storedMoviesKey: String = "storedMovies"
    
    /**
     Save a movie with the given notification and record the movie times seen
     - Parameters:
        - notification: a Notification object
     */
    static func saveMovie(with notification: Notification) {
        guard let userInfo = notification.userInfo,
              var movie = userInfo[movieNotificationKey] as? Movie else { return }
        movie.movieSeenCount = 1
        var movieList = MoviesList(movies: [movie])
        if let result = getMovies() {
            var storedMovies = result.movies
            if let movieIndex = storedMovies.firstIndex(where: { $0.id == movie.id }) {
                let removedMovie = storedMovies.remove(at: movieIndex)
                movie.movieSeenCount = 1 + (removedMovie.movieSeenCount ?? 0)
            }
            storedMovies.append(movie)
            movieList.movies = storedMovies
        }
        let data = try? JSONEncoder().encode(movieList)
        UserDefaults.standard.set(data, forKey: storedMoviesKey)
    }
    
    /**
     Gets the stored movies from user defaults
     - Returns: a MoviesList object
     */
    static func getMovies() -> MoviesList? {
        if let data = UserDefaults.standard.object(forKey: storedMoviesKey) as? Data,
           let result = try? JSONDecoder().decode(MoviesList.self, from: data) {
            return result
        }
        return nil
    }
}
