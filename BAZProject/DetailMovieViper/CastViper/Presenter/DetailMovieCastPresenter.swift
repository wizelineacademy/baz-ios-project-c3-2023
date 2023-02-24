//
//  DetailMovieCastPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 16/02/23.
//

import UIKit

class DetailMovieCastPresenter: DetailMovieCastPresenterProtocol {

    var presenterMain: DetailMovieCastProtocol?
    var interactor: DetailMovieCastInteractorInputProtocol?
    var cast: [Cast] = []
    private let movieApi : MovieAPI = MovieAPI()
    
    /// Get the cast of the movie
    ///
    /// - Parameter idMovie: integer that represents the id of the movie
    func getCast(idMovie: Int) {
        interactor?.getCast(idMovie: idMovie)
    }
    
    /// Get the cast count of the movie
    ///
    /// - Returns: integer that represents the count of the cast
    func getCastCount() -> Int {
        if cast.count > 5 { return 6 }
        return cast.count
    }
    
    /// Get the cast of the movie
    ///
    /// - Parameter index: integer that represents the index of the cast
    /// - Returns: return the cast object of the index
    func getCast(index: Int) -> Cast {
        return cast[index]
    }
    
    /// Get an image from the MovieApi class using the castlImage and return and UIImage
    ///
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getCastImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: cast[index].profile_path ?? "") { castImage in
            completion(castImage)
        }
    }
}

extension DetailMovieCastPresenter: DetailMovieCastInteractorOutputProtocol {
    
    func pushCast(cast: [Cast]) {
        self.cast = cast
        presenterMain?.informSuccesfulPresenterCast()
    }
}
