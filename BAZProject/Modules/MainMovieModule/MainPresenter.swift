//
//  MainPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
   
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
}

extension MainPresenter: MainInteractorOutputProtocol{
    func goToSearchMovieView() {
        guard let view = view as? UIViewController else{return}
        SearchMovieRouter().presentView(from: view)
    }
    
    func viewDidLoad() {
        MovieAPI().getApiData(from: .recommendations(movieId: "603"), handler: { data in
            do{
                let movies =  DecodeUtility.decode(Movies.self, from: data)
            }
        })
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "MoviesTableViewCell",
                                  bundle: nil)
        view?.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "MoviesTableViewCell")
    }
    
}
