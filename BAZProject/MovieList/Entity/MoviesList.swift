//
//  MoviesList.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

struct MoviesList: Codable, MoviesUpdater {
    typealias MoviesObject = MoviesList
    
    var movies: [Movie]
    var currentPage: Int?
    var nextPage: Int?
    var rowsToUpdate: [IndexPath]?
    var rowsToInsert: [IndexPath]?
    
    init(movies: [Movie] = []) {
        self.movies = movies
        self.currentPage = 1
    }
    
    init(movies: [Movie], currentPage: Int?, nextPage: Int?, rowsToUpdate: [IndexPath]?, rowsToInsert: [IndexPath]?) {
        self.movies = movies
        self.currentPage = currentPage
        self.nextPage = nextPage
        self.rowsToUpdate = rowsToUpdate
        self.rowsToInsert = rowsToInsert
    }
}
