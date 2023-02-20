//
//  WatchedMovieProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

protocol WatchedMovieViewProtocols: AnyObject {
    var presenter: WatchedMoviePresenterProtocols? { get set }
}

protocol WatchedMoviePresenterProtocols: AnyObject {
    var view: WatchedMovieViewProtocols? { get set }
    var interactor: WatchedMovieInteractorInputProtocols? { get set }
}

protocol WatchedMovieInteractorInputProtocols: AnyObject {
    var presenter: WatchedMovieInteractorOutputProtocols? { get set }
}

protocol WatchedMovieInteractorOutputProtocols: AnyObject {
    
}
