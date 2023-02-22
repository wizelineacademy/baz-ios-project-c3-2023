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
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: Properties VIP
    weak var viewController: HomeDisplayLogic?
    
    func presentFechedMoviesForSection(response: Home.FetchMoviesBySection.Response) {
        DispatchQueue.main.async {
            let displayedMoviesBySection = response.movies.prefix(response.numberOfMoviesToShow).map { movie in
                return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "")
            }
            
            self.viewController?.displayFetchedMoives(viewModel: Home.FetchMoviesBySection.ViewModel(displayedMovies: Home.FetchMoviesBySection.ViewModel.SectionWithMovies(section: response.section, movies: displayedMoviesBySection)))
        }
    }
    
    func presentErrorMessage(error: Home.FetchMoviesBySection.Error) {
        
    }
    
    func presentMovieSections(response: Home.GetMoviesSection.Response) {
        viewController?.displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel(displayedSections: response.sections))
    }
}
