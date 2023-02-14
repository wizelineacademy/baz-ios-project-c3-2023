//
//  DetailProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    var detailType: DetailType? { get set }
}

protocol DetailPresenterProtocol: AnyObject {
    var router: DetailRouterProtocol? { get set}
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
}

protocol DetailRouterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    static func createModule(detailType: DetailType) -> UIViewController
}

protocol DetailInteractorOutputProtocol: AnyObject { }

protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
}
