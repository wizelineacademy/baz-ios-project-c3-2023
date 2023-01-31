//
//  ErrorPageProtocols.swift
//  BAZProject
//
//  Created by 1058889 on 31/01/23.
//

import UIKit

protocol ErrorPageViewProtocol: AnyObject {
    var presenter: ErrorPagePresenterProtocol? { get set }
}

protocol ErrorPagePresenterProtocol: AnyObject {
    var router: ErrorPageRouterProtocol? { get set}
    var view: ErrorPageViewProtocol? { get set }
    var interactor: ErrorPageInteractorInputProtocol? { get set }
    
    func closeThisInstance()
}

protocol ErrorPageRouterProtocol: AnyObject {
    static func createModule(errorType: ErrorType) -> UIViewController
    func closeThisInstance()
}

protocol ErrorPageInteractorOutputProtocol: AnyObject {
}

protocol ErrorPageInteractorInputProtocol: AnyObject {
    var presenter: ErrorPageInteractorOutputProtocol? { get set }
}
