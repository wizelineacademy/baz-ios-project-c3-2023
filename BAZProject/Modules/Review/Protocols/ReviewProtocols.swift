//  ReviewProtocols.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol ReviewViewProtocol: AnyObject {
    var presenter: ReviewPresenterProtocol? { get set }

    func updateView(data: ReviewResult)
    func stopLoading()
    func setErrorGettingData(_ status: Bool)
}

// MARK: View Input (View -> Presenter)
protocol ReviewPresenterProtocol: AnyObject {
    var router: ReviewRouterProtocol? { get set}
    var view: ReviewViewProtocol? { get set }
    var interactor: ReviewInteractorInputProtocol? { get set }
    
    func willFetchReview()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol ReviewInteractorOutputProtocol: AnyObject {
    func onReceivedReview(_ result: ReviewResult)
    func showViewError(_ error: Error)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol ReviewInteractorInputProtocol: AnyObject {
    var presenter: ReviewInteractorOutputProtocol? { get set }
    var dataManager: ReviewDataManagerInputProtocol? { get set }
    func fetchReview()
}

// MARK: Interactor Input (Interactor -> DataManager)
protocol ReviewDataManagerInputProtocol: AnyObject {
    var interactor: ReviewDataManagerOutputProtocol? { get set }
    
    /// This method will request for Review.
    /// - Parameters:
    ///   - urlString: The url which returns Review.
    func requestReview(_ urlString: String)
}

// MARK: Interactor Output (DataManager -> Interactor)
protocol ReviewDataManagerOutputProtocol: AnyObject {
    func handleGetReview(_ result: ReviewResult)
    func handleErrorService(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol ReviewRouterProtocol: AnyObject {
    var view: ReviewViewProtocol? { get set }
    static func createModule() -> UIViewController
    func showViewError(_ errorType: ErrorType)
}
