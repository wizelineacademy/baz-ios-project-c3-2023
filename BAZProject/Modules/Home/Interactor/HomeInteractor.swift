//  HomeInteractor.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class HomeInteractor {
    // MARK: - Protocol properties
    weak var presenter: HomeInteractorOutputProtocol?
    var dataManager: HomeDataManagerInputProtocol?
}

extension HomeInteractor: HomeInteractorInputProtocol {
    func fetchPopularMovies() {
        dataManager?.requestPopularMovies(Endpoint.poularMovies.urlString)
    }

    func fetchMovieTopRated() {
        dataManager?.requestMovieTopRated(Endpoint.topRated.urlString)
    }

    func fetchNowPlaying() {
        dataManager?.requestNowPlaying(Endpoint.nowPlaying.urlString)
    }
}

extension HomeInteractor: HomeDataManagerOutputProtocol {
    func handleGetPopularMovies(_ result: [PopularMoviesModelResult]) {
        presenter?.onReceivedPopularMovies(result)
    }

    func handleGetMovieTopRated(_ result: [MovieTopRatedResult]) {
        presenter?.onReceivedMovieTopRated(result)
    }

    func handleGetNowPlaying(_ result: [NowPlayingResult]) {
        presenter?.onReceivedNowPlaying(result)
    }

    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
