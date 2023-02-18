//
//  DetailMovieRouter.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation
import UIKit

class DetailMovieRouter: DetailMovieRouterProtocol {

    class func createDetailMovieModule(idMovie: Int) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailMovieView")
        if let view = viewController as? DetailMovieView {
            let presenter: DetailMoviePresenterProtocol & DetailMovieInteractorOutputProtocol & DetailMovieCastProtocol & DetailMovieReviewProtocol & DetailMovieSimilarProtocol & DetailMovieRecommendationProtocol = DetailMoviePresenter()
            let presenterCast: DetailMovieCastPresenterProtocol & DetailMovieCastInteractorOutputProtocol = DetailMovieCastPresenter()
            let presenterReview: DetailMovieReviewPresenterProtocol & DetailMovieReviewInteractorOutputProtocol = DetailMovieReviewPresenter()
            let presenterSimilar: DetailMovieSimilarPresenterProtocol & DetailMovieSimilarInteractorOutputProtocol = DetailMovieSimilarPresenter()
            let presenterRecommendation: DetailMovieRecommendationPresenterProtocol & DetailMovieRecommendationInteractorOutputProtocol = DetailMovieRecommendationPresenter()
            let interactor: DetailMovieInteractorInputProtocol & DetailMovieRemoteDataManagerOutputProtocol = DetailMovieInteractor()
            let interactorCast: DetailMovieCastInteractorInputProtocol & DetailMovieCastRemoteDataManagerOutputProtocol = DetailMovieCastInteractor()
            let interactorReview: DetailMovieReviewInteractorInputProtocol & DetailMovieReviewRemoteDataManagerOutputProtocol = DetailMovieReviewInteractor()
            let interactorSimilar: DetailMovieSimilarInteractorInputProtocol & DetailMovieSimilarRemoteDataManagerOutputProtocol = DetailMovieSimilarInteractor()
            let interactorRecommendation: DetailMovieRecommendationInteractorInputProtocol & DetailMovieRecommendationRemoteDataManagerOutputProtocol = DetailMovieRecommendationInteractor()
            let remoteDataManager: DetailMovieRemoteDataManagerInputProtocol = DetailMovieRemoteDataManager()
            let remoteDataManagerCast: DetailMovieCastRemoteDataManagerInputProtocol = DetailMovieCastRemoteDataManager()
            let remoteDataManagerReview: DetailMovieReviewRemoteDataManagerInputProtocol = DetailMovieReviewRemoteDataManager()
            let remoteDataManagerSimilar: DetailMovieSimilarRemoteDataManagerInputProtocol = DetailMovieSimilarRemoteDataManager()
            let remoteDataManagerRecommendation: DetailMovieRecommendationRemoteDataManagerInputProtocol = DetailMovieRecommendationRemoteDataManager()
            let router: DetailMovieRouterProtocol = DetailMovieRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.idMovie = idMovie
            presenter.presenterCast = presenterCast
            presenter.presenterReview = presenterReview
            presenter.presenterSimilar = presenterSimilar
            presenter.presenterRecommendation = presenterRecommendation
            presenterCast.presenterMain = presenter
            presenterReview.presenterMain = presenter
            presenterSimilar.presenterMain = presenter
            presenterRecommendation.presenterMain = presenter
            presenterCast.interactor = interactorCast
            presenterReview.interactor = interactorReview
            presenterSimilar.interactor = interactorSimilar
            presenterRecommendation.interactor = interactorRecommendation
            interactorCast.presenter = presenterCast
            interactorCast.remoteDataManager = remoteDataManagerCast
            interactorReview.presenter = presenterReview
            interactorReview.remoteDataManager = remoteDataManagerReview
            interactorSimilar.presenter = presenterSimilar
            interactorSimilar.remoteDataManager = remoteDataManagerSimilar
            interactorRecommendation.presenter = presenterRecommendation
            interactorRecommendation.remoteDataManager = remoteDataManagerRecommendation
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManagerCast.remoteRequestHandler = interactorCast
            remoteDataManagerReview.remoteRequestHandler = interactorReview
            remoteDataManagerSimilar.remoteRequestHandler = interactorSimilar
            remoteDataManagerRecommendation.remoteRequestHandler = interactorRecommendation
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "DetailMovieView", bundle: Bundle.main)
    }
    
}
