//
//  MovieDetailsPresenter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsPresentationLogic {
    func presentLoadView(response: MovieDetails.LoadView.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {

    // MARK: Properties VIP
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentLoadView(response: MovieDetails.LoadView.Response) {
        let viewModel = MovieDetails.LoadView.ViewModel(title: response.movie.title)
        viewController?.displayView(viewModel: viewModel)
    }
}
