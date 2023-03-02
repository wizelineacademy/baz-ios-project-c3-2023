//
//  DetailProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    var idMovie: String? { get set }

    func updateView(data: MovieDetailResult)
    func updateView(data: [ReviewResult])
    func updateView(data: [SimilarMovieModelResult])
    func updateView(data: [RecomendationMovieModelResult])
    func stopLoading()
}

protocol DetailPresenterProtocol: AnyObject {
    var router: DetailRouterProtocol? { get set}
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }

    func isLoading() -> Bool
    func errorGettingData() -> Bool
    func willFetchMovie(of idMovie: String)
    func willFetchReview(of idMovie: String)
    func willFetchSimilarMovie(of idMovie: String)
    func willFetchMovieRecomendation(of idMovie: String)
    func willShowDetail(of idMovie: String)
}

protocol DetailRouterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    static func createModule(of idMovie: String) -> UIViewController
    func showViewError(_ errorType: ErrorType)
    func showDetail(of idMovie: String)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func onReceivedMedia(result: MovieDetailResult)
    func onReceivedReview(_ result: [ReviewResult])
    func onReceivedReview(_ result: [SimilarMovieModelResult])
    func onReceivedMovieRecomendation(_ result: [RecomendationMovieModelResult])
    func showViewError(_ error: Error)
}

protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    var dataManager: DetailDataManagerInputProtocol? { get set }

    func fetchMovie(of idMovie: String)
    func fetchReview(of idMovie: String)
    func fetchSimilarMovie(of idMovie: String)
    func fetchMovieRecomendation(of idMovie: String)
}

// Interactor > DataManager
protocol DetailDataManagerInputProtocol: AnyObject {
    var interactor: DetailDataManagerOutputProtocol? { get set }

    /// This method will request for media type.
    /// - Parameters:
    ///   - urlString: The url which returns the media of movie, person, o tv.
    func requestMovie(_ urlString: String)

    /// This method will request for Review.
    /// - Parameters:
    ///   - urlString: The url which returns Review.
    func requestReview(_ urlString: String)

    func requestSimilarMovie(_ urlString: String)
    func requestMovieRecomendation(_ urlString: String)
}

// DataManager > Interactor
protocol DetailDataManagerOutputProtocol: AnyObject {
    func handleGetMovie(_ result: MovieDetailResult)
    func handleGetReview(_ result: [ReviewResult])
    func handleGetSimilarMovie(_ result: [SimilarMovieModelResult])
    func handleGetMovieRecomendation(_ result: [RecomendationMovieModelResult])
    func handleErrorService(_ error: Error)
}
