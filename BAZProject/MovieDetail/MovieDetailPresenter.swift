//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import UIKit

class MovieDetailPresenter {
    //MARK: - Properties
    weak var view: MovieDetailViewIntputProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var router: MovieDetailRouterProtocol?
    
    init(view: MovieDetailViewIntputProtocol,
         interactor: MovieDetailInteractorInputProtocol,
         router: MovieDetailRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

//MARK: - extension
extension MovieDetailPresenter: MovieDetailViewOutputProtocol {
    
    func fetchModel() {
        interactor?.fetchModel()
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func presentView(model: Movie) {
        view?.loadView(from: model)
    }
    
    
}
