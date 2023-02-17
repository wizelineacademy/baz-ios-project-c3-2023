//
//  ListMoviesRouter.swift
//  BAZProject
//
//  Created by hlechuga on 02/02/23.
//

import Foundation
import UIKit

class ListMoviesRouter {
    
    func showListMovies(window: UIWindow?) {
        let listMoviesView = ListMoviesView()
        let listMoviesInteractor = ListMoviesInteractor()
        let listMoviesPresenter = ListMoviesPresenter(listMoviesInteractor: listMoviesInteractor)
        listMoviesPresenter.modelPageProtocol = listMoviesView
        listMoviesView.listMoviesPresenter = listMoviesPresenter
        
        window?.rootViewController = listMoviesView
        window?.makeKeyAndVisible()
    }
}
