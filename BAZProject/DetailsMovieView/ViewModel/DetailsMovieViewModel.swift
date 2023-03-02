//
//  DetailsMovieViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

final class DetailsMovieViewModel {
    
    let movieApi = MovieAPI()
    
    func fetchDetailMovie(idMovie: Int) -> MovieDetail? {
        
        var detailsMovie: MovieDetail? = nil
        movieApi.getDetailMovie(idMovie: idMovie) { details in
            detailsMovie = details
        }
        return detailsMovie
    }
}
