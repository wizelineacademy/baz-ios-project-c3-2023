//
//  FavoriteMovieViewProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

protocol FavoriteMovieViewProtocol: AnyObject {
    var presenter: FavoriteMoviePresenterProtocol? { get set }
}

protocol FavoriteMoviePresenterProtocol: AnyObject {
    var view: FavoriteMovieViewProtocol? { get set }
    var interactor: FavoriteMovieInteractorInputProtocol? { get set }
}

protocol FavoriteMovieInteractorInputProtocol: AnyObject {
    var presenter: FavoriteMovieInteractorOutputProtocol? { get set }
}

protocol FavoriteMovieInteractorOutputProtocol: AnyObject {
    
}
