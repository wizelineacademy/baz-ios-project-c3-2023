//
//  CastProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import UIKit

protocol DetailMovieCastPresenterProtocol: AnyObject {
    var presenterMain: DetailMovieCastProtocol? { get set }
    var interactor: DetailMovieCastInteractorInputProtocol? { get set }
    
    func getCast(idMovie: Int)
    func getCastCount() -> Int
    func getCast(index: Int) -> Cast
    func getCastImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

protocol DetailMovieCastInteractorOutputProtocol: AnyObject {
    func pushCast(cast: [Cast])
}

protocol DetailMovieCastInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieCastInteractorOutputProtocol? { get set }
    var remoteDataManager: DetailMovieCastRemoteDataManagerInputProtocol? { get set }
    
    func getCast(idMovie: Int)
}

protocol DetailMovieCastRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieCastRemoteDataManagerOutputProtocol? { get set }
    
    func getCast(idMovie: Int?)
}

protocol DetailMovieCastRemoteDataManagerOutputProtocol: AnyObject {
    func pushCast(cast: [Cast])
}
