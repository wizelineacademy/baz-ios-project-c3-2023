//
//  DetailMoviePresenter.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import UIKit

class DetailMoviePresenter: DetailMoviePresenterProtocol  {
  
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    var idMovie: Int?
    private let movieApi : MovieAPI = MovieAPI()
    var detailsMovie: DetailMovie?
    var cast: [Cast] = []
    var reviews: [Reviews] = []
    var similars: [Movie] = []
    var recommendations: [Movie] = []
    var tableViewSize = 170
    var tableCount = 5
    
    func viewDidLoad() {
        interactor?.getDetails(idMovie: idMovie)
        interactor?.getCast(idMovie: idMovie)
        interactor?.getReviews(idMovie: idMovie)
        interactor?.getSimilar(idMovie: idMovie)
        interactor?.getRecommendations(idMovie: idMovie)
    }
    
    func getDetailImage(completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: detailsMovie?.backdrop_path ?? "") { detailImage in
            if let detailImage = detailImage {
                completion(detailImage)
            } else {
                completion(nil)
            }
        }
    }
    
    func getTableSize() -> Int {
        return tableViewSize
    }

    func getTableCout() -> Int {
        return tableCount
    }

    func getCastCount() -> Int {
        if cast.count > 5 { return 6 }
        return cast.count
    }
    
    func getCast(index: Int) -> Cast {
        return cast[index]
    }
    
    func getCastImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: cast[index].profile_path ?? "") { castImage in
            if let castImage = castImage {
                completion(castImage)
            } else {
                completion(nil)
            }
        }
    }
    
    func getReviewCount() -> Int {
        return reviews.count

    }
    
    func getReview(index: Int) -> Reviews {
        return reviews[index]
    }
    
    func getSimilarCount() -> Int {
        if similars.count > 5 { return 6 }
        return similars.count
    }
    
    func getSimilarImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: similars[index].poster_path ?? "") { similarImage in
            if let similarImage = similarImage {
                completion(similarImage)
            } else {
                completion(nil)
            }
        }
    }
    
    func getRecommendationCount() -> Int {
        if recommendations.count > 5 { return 6 }
        return recommendations.count
    }
    
    func getRecommendationImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: recommendations[index].poster_path ?? "") { recommendationImage in
            if let recommendationImage = recommendationImage{
                completion(recommendationImage)
            } else {
                completion(nil)
            }
        }
    }
    
   
  
}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
  
    func pushDetailMovie(detailMovie: DetailMovie) {
        self.detailsMovie = detailMovie
        view?.setupDetailsView()
        view?.reloadView()
    }
    
    func pushCast(cast: [Cast]) {
        self.cast = cast
        view?.reloadView()
    }
    
    func pushNotCast() {
        view?.reloadView()
    }
    
    func pushReviews(reviews: [Reviews]) {
        self.reviews = reviews
        view?.reloadView()
    }
    
    func pushNotRewiews() {
        view?.reloadView()
    }
    
    
    func pushSimilar(similar: [Movie]) {
        self.similars = similar
        view?.reloadView()
    }
    
    func pushNotSimilar() {
        view?.reloadView()
    }
    
    
    func pushRecommendations(recommendations: [Movie]) {
        self.recommendations = recommendations
        view?.reloadView()
    }
    
    func pushNotRecommentations() {
        view?.reloadView()
    }
    
  
}
