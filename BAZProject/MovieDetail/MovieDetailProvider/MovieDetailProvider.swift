//
//  MovieDetailProvider.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

final class MovieDetailProvider {
    let movie: Movie
    var details: [GenericTableViewRow]
    let group: DispatchGroup
    
    init(movie: Movie) {
        self.movie = movie
        self.details = []
        self.group = DispatchGroup()
    }
    
    
    /// Fetch every movie detail with dispath group, when all the task are completed this group send a notification to communicate that the task is completed
    /// - Parameter detail: a Detail enum that retrieves its corresponding end point
    func fetch(detail: Detail) {
        self.group.enter()
        switch detail {
        case .credits:
            fetch(request: detail.endPoint(for: movie.id)) { [weak self] (result: Result<Actors, Error>) in
                switch result {
                case .success(var actors):
                    actors.detail = detail
                    if !actors.actors.isEmpty {
                        self?.details.append(actors)
                    }
                default:
                    break
                }
                self?.group.leave()
            }
        case .reviews:
            fetch(request: detail.endPoint(for: movie.id)) { [weak self] (result: Result<Reviews, Error>) in
                switch result {
                case .success(var reviews):
                    reviews.detail = detail
                    if !reviews.reviews.isEmpty {
                        self?.details.append(reviews)
                    }
                default:
                    break
                }
                self?.group.leave()
            }
        case .recommendations:
            fetch(request: detail.endPoint(for: movie.id)) { [weak self] (result: Result<PagedMovies, Error>) in
                switch result {
                case .success(var recommendations):
                    recommendations.detail = detail
                    if !recommendations.movies.isEmpty {
                        self?.details.append(recommendations)
                    }
                default:
                    break
                }
                self?.group.leave()
            }
        case .similar:
            fetch(request: detail.endPoint(for: movie.id)) { [weak self] (result: Result<PagedMovies, Error>) in
                switch result {
                case .success(var similarMovies):
                    similarMovies.detail = detail
                    if !similarMovies.movies.isEmpty {
                        self?.details.append(similarMovies)
                    }
                default:
                    break
                }
                self?.group.leave()
            }
        }
    }
}

extension MovieDetailProvider: MovieDetailProviderProtocol {
    
    /// Gets the title of the view controller
    /// - Returns: a string that represents the title
    func getTitle() -> String {
        self.movie.title
    }
    
    /// Gets necesary cell clases for movie details
    /// - Returns: a GenericTableViewCell array
    func getCellClasses() -> [any GenericTableViewCell.Type] {
        [
            MovieDetailTableViewCell.self,
            SliderTableViewCell.self
        ]
    }
    
    /// Returns synchronously a Result that on success case a GenericTableViewRow array, otherwise an error
    /// - Parameter completion: a closure that is called when the task is completed
    func fetchMoreDetails(completion: @escaping (Result<[GenericTableViewRow], Error>) -> Void) {
        Detail.allCases.forEach({ fetch(detail: $0) })
        self.group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.details.sort(by: { $0.id < $1.id })
            self.details.insert(self.movie, at: 0)
            return completion(.success(self.details))
        }
    }
}
