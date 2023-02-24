//
//  WatchedMovieViewController.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class WatchedMovieViewController: UIViewController, WatchedMovieViewProtocols {
    var presenter: WatchedMoviePresenterProtocols?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vistas"
    }
}
