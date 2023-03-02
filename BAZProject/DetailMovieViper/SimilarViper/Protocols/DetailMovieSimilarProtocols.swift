//
//  DetailMovieSimilarProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import UIKit

protocol DetailMovieSimilarPresenterProtocol: AnyObject {
    var presenterMain: DetailMovieCellPresenterProtocol? { get set }
    var interactor: DetailMovieSimilarInteractorInputProtocol? { get set }
    
    func getSimilar(idMovie: Int)
    func getSimilarCount() -> Int
    func getSimilar(index: Int) -> Movie
    func getSimilarImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

protocol DetailMovieSimilarInteractorOutputProtocol: AnyObject {
    func pushSimilar(similar: [Movie])
    func pushNotSimilar()
}

protocol DetailMovieSimilarInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieSimilarInteractorOutputProtocol? { get set }
    var remoteDataManager: DetailMovieSimilarRemoteDataManagerInputProtocol? { get set }
    
    func getSimilar(idMovie: Int)
}

protocol DetailMovieSimilarRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieSimilarRemoteDataManagerOutputProtocol? { get set }
    
    func getSimilar(idMovie: Int)
}

protocol DetailMovieSimilarRemoteDataManagerOutputProtocol: AnyObject {
    func pushSimilar(similar: [Movie])
    func pushNotSimilar()
}
