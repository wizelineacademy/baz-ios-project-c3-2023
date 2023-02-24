//
//  FavoriteMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class FavoriteMovieView: UIViewController {
    var presenter: FavoriteMoviePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tus Favoritos"
    }
}

extension FavoriteMovieView: FavoriteMovieViewProtocol {
    
}
