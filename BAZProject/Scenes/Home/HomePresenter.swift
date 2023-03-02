//
//  HomePresenter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomePresentationLogic: AnyObject {
    func presentFechedMoviesForSection(response: Home.FetchMoviesBySection.Response)
    func presentMovieSections(response: Home.GetMoviesSection.Response)
    func presentErrorMessage(error: Home.FetchMoviesBySection.Error)
    func presentMoviesWatched(response: Home.SaveMovieWatched.Response)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: Properties VIP
    weak var viewController: HomeDisplayLogic?
    
    func presentFechedMoviesForSection(response: Home.FetchMoviesBySection.Response) {
        DispatchQueue.main.async { [weak self] in
            let displayedMoviesBySection = response.movies.map { movie in
                return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", name: movie.title ?? "", description: movie.overview ?? "")
            }
            
            self?.viewController?.displayFetchedMoives(viewModel: Home.FetchMoviesBySection.ViewModel(displayedMovies: Home.FetchMoviesBySection.ViewModel.SectionWithMovies(section: response.section, movies: displayedMoviesBySection)))
        }
    }
    
    func presentErrorMessage(error: Home.FetchMoviesBySection.Error) {
        
    }
    
    func presentMovieSections(response: Home.GetMoviesSection.Response) {
        viewController?.displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel(displayedSections: response.sections))
    }
    
    func presentMoviesWatched(response: Home.SaveMovieWatched.Response) {
        let viewModel = Home.SaveMovieWatched.ViewModel(movies: response.movies)
        viewController?.displayMoviesWatched(viewModel: viewModel)
    }
}
