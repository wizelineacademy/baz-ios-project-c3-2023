//
//  DetailMovieSimilarPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import UIKit

class DetailMovieSimilarPresenter: DetailMovieSimilarPresenterProtocol {
  
    var presenterMain: DetailMovieSimilarProtocol?
    var interactor: DetailMovieSimilarInteractorInputProtocol?
    var similar: [Movie] = []
    private let movieApi : MovieAPI = MovieAPI()
    
    /// Get the similar of the movie
    ///
    /// - Parameter idMovie: integer that represents the id of the movie
    func getSimilar(idMovie: Int) {
        interactor?.getSimilar(idMovie: idMovie)
    }
    
    /// Get the similar count of the movie
    ///
    /// - Returns: integer that represents the count of the similar
    func getSimilarCount() -> Int {
        if similar.count > 5 { return 6 }
        return similar.count
    }
    
    /// Get the similar of the movie
    ///
    /// - Parameter index: integer that represents the index of the similar
    /// - Returns: return the similar object of the index
    func getSimilar(index: Int) -> Movie {
        return similar[index]
    }
    
    /// Get an image from the MovieApi class using the similarImage and return and UIImage
    ///
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getSimilarImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        ImageProvider.shared.getImage(for: similar[index].poster_path ?? "") { similarImage in
            completion(similarImage)
        }
    }
}

extension DetailMovieSimilarPresenter: DetailMovieSimilarInteractorOutputProtocol {
    func pushNotSimilar() {
        presenterMain?.informErrorPresenterSimilar()
    }
    
    func pushSimilar(similar: [Movie]) {
        self.similar = similar
        presenterMain?.informSuccesfulPresenterSimilar()
    }
}
