//
//  PrincipalViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

final class PrincipalViewModel {
    let movieApi = MovieAPI()
    
    /// Obtains an array specific movies
    func fetchMovies(with type: TypeMovieList) -> [Movie] {
        var moviesTypeArray: [Movie] = []
        movieApi.getMovies(typeMovie: type, completion: { moviesArray in
            moviesTypeArray = moviesArray ?? []
        })
        return moviesTypeArray
    }
}
