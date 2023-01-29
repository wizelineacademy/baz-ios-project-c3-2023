//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//
import UIKit

protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
    func updateView(data: [MovieResult])
    func showErrorView()
    func stopLoading()
}

protocol TrendingPresenterProtocol: AnyObject {
    var router: TrendingRouterProtocol? { get set}
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingViewInteractorInputProtocol? { get set }

    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
}

protocol TrendingRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol TrendingViewInteractorOutputProtocol: AnyObject {
    func getTrendingMedia(success: Bool, result: [MovieResult]?)
}

protocol TrendingViewInteractorInputProtocol: AnyObject {
    var presenter: TrendingViewInteractorOutputProtocol? { get set }
    
    func getTrendingMedia(mediaType: MediaType, timeWindow: TimeWindowType)
}

protocol TrendingDataManagerProtocol: AnyObject {
    
}
