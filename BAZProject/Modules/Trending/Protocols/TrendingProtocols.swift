//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//
import UIKit

protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }

    func updateView(data: [MovieResult])
    func stopLoading()
    func setErrorGettingData(_ status: Bool)
}

protocol TrendingPresenterProtocol: AnyObject {
    var router: TrendingRouterProtocol? { get set}
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }

    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
}

protocol TrendingRouterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }

    static func createModule() -> UIViewController
    func showViewError(_ errorType: ErrorType)
}

protocol TrendingInteractorOutputProtocol: AnyObject {
    func getTrendingMedia(result: [MovieResult])
    func showViewError(_ error: Error)
}

protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var dataManager: TrendingDataManagerInputProtocol? { get set }
    
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
}

protocol TrendingDataManagerInputProtocol: AnyObject {
    var interactor: TrendingDataManagerOutputProtocol? { get set }
    
    func requestTrendingMedia(_ urlString: String)
}

protocol TrendingDataManagerOutputProtocol: AnyObject {
    func handleGetTrendingMedia(_ result: [MovieResult])
    func handleErrorService(_ error: Error)
}
