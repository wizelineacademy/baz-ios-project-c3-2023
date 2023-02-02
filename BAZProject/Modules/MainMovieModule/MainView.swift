//
//  MainView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainView: UIViewController {
    var presenter: MainPresenterProtocol?
    var movies: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieAPI.getMovies(url: .recommendations(movieId: "603"), handler: { [weak self] data in
            do{
                self?.movies =  DecodeUtility.decode(Movies.self, from: data)
                print(self?.movies)
            }
        })
    }
    
    
    
}

extension MainView: MainViewProtocol{
    
    
}
