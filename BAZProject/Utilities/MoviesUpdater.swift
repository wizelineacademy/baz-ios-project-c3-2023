//
//  MoviesUpdater.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 01/03/23.
//

import Foundation

protocol MoviesUpdater {
    associatedtype MoviesObject: MoviesUpdater
    
    var movies: [Movie] { get set }
    var currentPage: Int? { get set }
    var nextPage: Int? { get set }
    var rowsToUpdate: [IndexPath]? { get set }
    var rowsToInsert: [IndexPath]? { get set }
    
    init(movies: [Movie], currentPage: Int?, nextPage: Int?, rowsToUpdate: [IndexPath]?, rowsToInsert: [IndexPath]?)
    
    func updatePages(currentPage: Int, of pages: Int) -> MoviesObject
    func updateMovies(with newMovies: [Movie]) -> MoviesObject
    func setNextPage(with page: Int?) -> MoviesObject
}

extension MoviesUpdater {
    /**
     Set the next page property
     - Parameters:
        - page: an integer value
     - Returns: the updated self MoviesUpdater object
     */
    func setNextPage(with page: Int?) -> MoviesObject {
        MoviesObject(
            movies: self.movies,
            currentPage: self.currentPage,
            nextPage: page,
            rowsToUpdate: self.rowsToUpdate,
            rowsToInsert: self.rowsToInsert
        )
    }
    
    /**
     Set the current and next page with the received data
     - Parameters:
        - currentPage: an integer that represents the current page
        - pages: an integer that represents the total of pages
     - Returns: the updated self MoviesUpdater object
     */
    func updatePages(currentPage: Int, of pages: Int) -> MoviesObject {
        MoviesObject(
            movies: self.movies,
            currentPage: currentPage,
            nextPage: currentPage < pages ? currentPage + 1 : nil,
            rowsToUpdate: self.rowsToUpdate,
            rowsToInsert: self.rowsToInsert
        )
    }
    
    /**
     Update the current movies with the received array
     - Parameters:
        - newMovies: a movies array
     - Returns: the updated self MoviesUpdater object
     */
    func updateMovies(with newMovies: [Movie]) -> MoviesObject {
        var aditionalMovies: [Movie] = []
        var repeatedMovies: [Movie] = []
        newMovies.forEach { movie in
            self.movies.first(where: { $0.id == movie.id }) == nil ?
                aditionalMovies.append(movie) :
                repeatedMovies.append(movie)
        }
        var rowsToInsert: [IndexPath]?
        var currentMovies = self.movies {
            didSet {
                rowsToInsert = self.getRowsToInsert(oldValues: oldValue, newValues: currentMovies)
            }
        }
        currentMovies.append(contentsOf: aditionalMovies)
        var rowsToUpdate: [IndexPath]?
        var updatedMovies = currentMovies
        if !repeatedMovies.isEmpty {
            rowsToUpdate = getRowsToUpdate(in: &repeatedMovies)
            if rowsToUpdate != nil {
                replaceMovies(in: &updatedMovies, with: repeatedMovies)
            }
        }
        return MoviesObject(
            movies: updatedMovies,
            currentPage: self.currentPage,
            nextPage: self.nextPage,
            rowsToUpdate: rowsToUpdate,
            rowsToInsert: rowsToInsert
        )
    }
    
    /**
     Look for new movies comparing the old values vs the new values
     - Parameters:
        - oldValues: a movies array that contents the old movies
        - newValues: a movies array that contents the updated movies
     - Returns: an array of IndexPath objects, if there are not new movies returns nil
     */
    private func getRowsToInsert(oldValues: [Movie], newValues: [Movie]) -> [IndexPath]? {
        let oldMovies = self.getHashedMovies(of: oldValues)
        let newRows = newValues.enumerated().compactMap { (index, movie) in
            return oldMovies[movie] == nil ? IndexPath(row: index, section: 0) : nil
        }
        return newRows.isEmpty ? nil : newRows
    }
    
    /**
     Look for the movies that needs to be updated
     - Parameters:
        - movies: a movies array
     - Returns: an array of IndexPath objects, if there are not new movies returns nil
     */
    private func getRowsToUpdate(in movies: inout [Movie]) -> [IndexPath]? {
        var moviesToUpdate: [Movie] = []
        let rowsToUpdate = movies.compactMap { movie -> IndexPath? in
            guard let index = self.movies.firstIndex(where: { $0.id == movie.id && $0.movieSeenCount != movie.movieSeenCount }) else { return nil }
            moviesToUpdate.append(movie)
            return IndexPath(row: index, section: 0)
        }
        movies = moviesToUpdate
        return rowsToUpdate.isEmpty ? nil : rowsToUpdate
    }
    
    /**
     Replace the current movies with the updated movies
     - Parameters:
        - movies: the updated movies array
     */
    private func replaceMovies(in movies: inout [Movie], with newMovies: [Movie]) {
        movies.enumerated().forEach { (index, movie) in
            if let updatedMovie = newMovies.first(where: { $0.id == movie.id }) {
                movies[index] = updatedMovie
            }
        }
    }
    
    /**
     Transform the received movies into hashed movies
     - Parameters:
        - movies: a movies array
     - Returns: a dictionary created with the received movies, with each movie as key
     */
    private func getHashedMovies(of movies: [Movie]) -> [Movie: Movie] {
        var currentMovies: [Movie: Movie] = [:]
        movies.forEach({ currentMovies[$0] = $0 })
        return currentMovies
    }
}
