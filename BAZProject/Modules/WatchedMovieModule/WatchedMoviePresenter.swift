//
//  WatchedMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class WatchedMoviePresenter: WatchedMoviePresenterProtocols, WatchedMovieInteractorOutputProtocols {
    var view: WatchedMovieViewProtocols?
    var interactor: WatchedMovieInteractorInputProtocols?
}
