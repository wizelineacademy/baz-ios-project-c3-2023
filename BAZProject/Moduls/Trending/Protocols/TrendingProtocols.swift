//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//
import UIKit

protocol TrendingProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }

    func updateView(data: [MovieResult])
    func showErrorView()
    func stopLoading()
}

protocol TrendingPresenterProtocol: AnyObject {
    var router: TrendingRouterProtocol? { get set}
    var view: TrendingProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }

    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
}

protocol TrendingRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol TrendingInteractorOutputProtocol: AnyObject {
    func getTrendingMedia(result: [MovieResult])
    func showViewError()
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
    func handleErrorService()
}
