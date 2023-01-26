//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//
import UIKit

protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
}

protocol TrendingPresenterProtocol: AnyObject {
    var router: TrendingRouterProtocol? { get set}
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingViewInteractorInputProtocol? { get set }
}

protocol TrendingRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol TrendingViewInteractorOutputProtocol: AnyObject {
}

protocol TrendingViewInteractorInputProtocol: AnyObject {
    var presenter: TrendingViewInteractorOutputProtocol? { get set }
    var providerNetworking: NetworkingProviderProtocol? { get set }
}
