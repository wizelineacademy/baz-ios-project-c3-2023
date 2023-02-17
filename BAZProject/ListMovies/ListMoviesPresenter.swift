//
//  ListMoviesPresenter.swift
//  BAZProject
//
//  Created by hlechuga on 02/02/23.
//

import Foundation

protocol ListMoviesViewProtocol: AnyObject {
    func update( movies: [AllMovieTypes] )
}

class ListMoviesPresenter {
    private var listMoviesInteractor = ListMoviesInteractor()
    var modelPageProtocol:ListMoviesViewProtocol?
    
    init(listMoviesInteractor: ListMoviesInteractor ) {
        self.listMoviesInteractor = listMoviesInteractor
    }
    
//    func onViewAppear() {
//            listMoviesInteractor.getMovies(forType: .trending, completion: {
//                pageMoviesResult in
//                self.modelPageProtocol?.update( movies: pageMoviesResult.results )
//            })
//    }
    
    func onViewAppear(){
        listMoviesInteractor.getMoviesAllCategories { allCategoriesMovies in
            self.modelPageProtocol?.update(movies: allCategoriesMovies)
        }
    }
}
