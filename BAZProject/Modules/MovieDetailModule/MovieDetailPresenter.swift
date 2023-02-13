//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInterceptorInputProtocol?
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func viewDidLoad() {
        if let idMovie = interactor?.data?.id {
            interactor?.movieApiData.getArrayDataMovie = [
                                                            .creditMovie(movieId: "\(idMovie)"): nil,
                                                            .similar(movieId: "\(idMovie)"): nil,
                                                            .recommendations(movieId: "\(idMovie)"): nil,
                                                            .reviews(movieId: "\(idMovie)"): nil
                                                            ]
        } else { debugPrint("idMovie not found") }
        getUI()
    }
    
    func getUI() {
        if let data = interactor?.data, let image = data.posterPath, let overviewTextView =  view?.overviewTextView {
            MovieAPI.getImage(from: image , handler: { image in
                self.view?.poster.image = image
            })
            overviewTextView.text = data.overview
        }
    }
    
    func getMoviesData(from api: URLApi){
        
    }
    
    
    func reloadData() {
        
    }

}
