//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

// MARK: - VIPER protocols

// View > Presenter
protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }

    func updateView()
    func stopLoading()
    func setErrorGettingData(_ status: Bool)
}

// Presenter > View
protocol TrendingPresenterProtocol: AnyObject {
    var router: TrendingRouterProtocol? { get set}
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var totalDataCount: Int? { get set }
    var data: [TrendingModel] { get set }

    func willFetchTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
    func willShowDetail(of detailType: DetailType)
    func willShowAlertLoading(with alertType: ErrorType)
    func willHideAlertLoading()
    func willFetchSearchMovie(by keyword: String)
}

// Presenter > Router
protocol TrendingRouterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }

    static func createModule() -> UIViewController
    func showViewError(_ errorType: ErrorType)
    func showDetail(of detailType: DetailType)
    func showAlertLoading(with alertType: ErrorType)
    func hideAlertLoading()
}

// Presenter > Interactor
protocol TrendingInteractorOutputProtocol: AnyObject {
    func onReceivedTrendingMedia(result: MovieResponse)
    func onReceivedSearchMovie(data: MovieResponse)
    func showViewError(_ error: Error)
}

// Interactor > Presenter
protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var dataManager: TrendingDataManagerInputProtocol? { get set }

    func fetchTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
    func fetchSearchMovie(with keyword: String)
}

// Interactor > DataManager
protocol TrendingDataManagerInputProtocol: AnyObject {
    var interactor: TrendingDataManagerOutputProtocol? { get set }

    /// This method wil request for type trending.
    /// - Parameters:
    ///   - urlString: The url which returns the trending media of movie, person, tv o all, by day or week.
    func requestTrendingMedia(_ urlString: String)
    func requestSearchMovie(_ urlString: String)
}

// DataManager > Interactor
protocol TrendingDataManagerOutputProtocol: AnyObject {
    func handleGetTrendingMedia(_ data: MovieResponse)
    func handleGetSearchMovie(_ data: MovieResponse)
    func handleErrorService(_ error: Error)
}
