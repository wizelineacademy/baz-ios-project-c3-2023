//
//  FavoriteMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import Foundation

class FavoriteMoviePresenter: FavoriteMoviePresenterProtocol, FavoriteMovieInteractorOutputProtocol {
    weak var view: FavoriteMovieViewProtocol?
    var interactor: FavoriteMovieInteractorInputProtocol?
    
    
}
