//
//  PrincipalViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

protocol PricipalView {
    var moviesPopular: [Movie] { get set }
    var moviesNowPlaying: [Movie] { get set }
    var moviesLatest: [Movie] { get set }
}

final class PrincipalViewModel {
    let movieApi = MovieAPI()
    var view: PricipalView
    
    init(view: PricipalView) {
        self.view = view
    }
    
    func fetchMovies(with type: TypeMovieList) {
        movieApi.getMovies(typeMovie: type, completion: { [weak self] moviesArray in
            switch type {
            case .popularity:
                self?.view.moviesPopular = moviesArray ?? []
            case .topRated:
                self?.view.moviesNowPlaying = moviesArray ?? []
            case .upcoming:
                self?.view.moviesLatest = moviesArray ?? []
            }
        })
    }
}
