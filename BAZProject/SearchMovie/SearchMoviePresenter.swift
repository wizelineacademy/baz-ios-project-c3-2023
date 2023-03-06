//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation

class SearchMoviePresenter {
    //MARK: - Properties
    weak var view: SearchViewInputProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    //MARK: - Init Methods
    init(view: SearchViewInputProtocol,
         interactor: SearchInteractorInputProtocol,
         router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Extensions
extension SearchMoviePresenter: SearchViewOutputProtocol {
    func fetchModel(with query: String) {
        interactor?.fetchModel(with: query)
    }
    
    func goToMovieDetail(with movie: Movie) {
        router?.goToMovieDetail(with: movie)
    }
}

extension SearchMoviePresenter: SearchInteractorOutputProtocol {
    func presentView(with model: [Movie]) {
        view?.loadView(from: model)
    }
}
