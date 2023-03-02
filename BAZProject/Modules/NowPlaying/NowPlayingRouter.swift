//
//  NowPlayingRouter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class NowPlayingRouter: NowPlayingRouterProtocol {

    class func createNowPlayingModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        let presenter: NowPlayingPresenterProtocol & NowPlayingInteractorOutputProtocol = NowPlayingPresenter()
        let interactor: NowPlayingInteractorInputProtocol & NowPlayingRemoteDataManagerOutputProtocol = NowPlayingInteractor()
        let remoteDataManager: NowPlayingRemoteDataManagerInputProtocol = NowPlayingRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: NowPlayingRouterProtocol = NowPlayingRouter()
            
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension NowPlayingRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
