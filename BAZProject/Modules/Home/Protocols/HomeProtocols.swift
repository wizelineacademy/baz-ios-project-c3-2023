//  HomeProtocols.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }

    func updateView(data: HomeResult)
    func stopLoading()
    func setErrorGettingData(_ status: Bool)
}

// MARK: View Input (View -> Presenter)
protocol HomePresenterProtocol: AnyObject {
    var router: HomeRouterProtocol? { get set}
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    
    func willFetchHome()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorOutputProtocol: AnyObject {
    func onReceivedHome(_ result: HomeResult)
    func showViewError(_ error: Error)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? { get set }
    var dataManager: HomeDataManagerInputProtocol? { get set }
    func fetchHome()
}

// MARK: Interactor Input (Interactor -> DataManager)
protocol HomeDataManagerInputProtocol: AnyObject {
    var interactor: HomeDataManagerOutputProtocol? { get set }
    
    /// This method will request for Home.
    /// - Parameters:
    ///   - urlString: The url which returns Home.
    func requestHome(_ urlString: String)
}

// MARK: Interactor Output (DataManager -> Interactor)
protocol HomeDataManagerOutputProtocol: AnyObject {
    func handleGetHome(_ result: HomeResult)
    func handleErrorService(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol HomeRouterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    static func createModule() -> UIViewController
    func showViewError(_ errorType: ErrorType)
}
