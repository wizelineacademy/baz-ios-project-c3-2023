//
//  DetailsMovieViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

protocol DetailsView {
    var movieDetail: MovieDetail? { get set }
}

final class DetailsMovieViewModel {
    
    let movieApi = MovieAPI()
    var view: DetailsView?
    
    init(view: DetailsView?) {
        self.view = view
    }
    
    func fetchDetailMovie(idMovie: Int) {
        movieApi.getDetailMovie(idMovie: idMovie) { [weak self] details in
            self?.view?.movieDetail = details
        }
    }
}
