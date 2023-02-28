//
//  DetailProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    var detailType: DetailType? { get set }

    func updateView(data: MovieDetailResult)
    func updateView(data: [ReviewResult])
    func stopLoading()
    func setErrorGettingData(_ status: Bool)
}

protocol DetailPresenterProtocol: AnyObject {
    var router: DetailRouterProtocol? { get set}
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }

    func isLoading() -> Bool
    func willFetchMedia(detailType: DetailType)
    func willFetchReview(of idMovie: String)
}

protocol DetailRouterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    static func createModule(detailType: DetailType) -> UIViewController
    func showViewError(_ errorType: ErrorType)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func onReceivedMedia(result: MovieDetailResult)
    func onReceivedReview(_ result: [ReviewResult])
    func showViewError(_ error: Error)
}

protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    var dataManager: DetailDataManagerInputProtocol? { get set }

    func fetchMedia(detailType: DetailType)
    func fetchReview(of idMovie: String)
}

// Interactor > DataManager
protocol DetailDataManagerInputProtocol: AnyObject {
    var interactor: DetailDataManagerOutputProtocol? { get set }

    /// This method will request for media type.
    /// - Parameters:
    ///   - urlString: The url which returns the media of movie, person, o tv.
    func requestMedia(_ urlString: String)

    /// This method will request for Review.
    /// - Parameters:
    ///   - urlString: The url which returns Review.
    func requestReview(_ urlString: String)
}

// DataManager > Interactor
protocol DetailDataManagerOutputProtocol: AnyObject {
    func handleGetMediaMovie(_ result: MovieDetailResult)
    func handleGetReview(_ result: [ReviewResult])
    func handleErrorService(_ error: Error)
}
