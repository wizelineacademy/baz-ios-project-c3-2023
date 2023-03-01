//
//  ListMoviesPresenter.swift
//  BAZProject
//
//  Created by hlechuga on 02/02/23.
//

import Foundation

class ListMoviesPresenter {
    //MARK: - Properties
    weak var view: ListMoviesViewInputProtocol?
    var interactor: ListMoviesInteractorInputProtocol?
    var router: ListMoviesRouterProtocol?
    
    //MARK: - Init methods
    init(view: ListMoviesViewInputProtocol,
         interactor: ListMoviesInteractorInputProtocol,
         router: ListMoviesRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Extension
extension ListMoviesPresenter: ListMoviesViewOutputProtocol {
    
    func fetchModel() {
        interactor?.fetchModel()
    }
    
    func goToNextViewController(with model: Movie) {
        router?.goToNextViewController(with: model)
    }
    
    func goToSearchViewController() {
        router?.goToSearchViewController()
    }
}

extension ListMoviesPresenter: ListMoviesInteractorOutputProtocol {
    
    func presentView(model: [AllMovieTypes]) {
        view?.loadView(from: model)
    }
    
}
