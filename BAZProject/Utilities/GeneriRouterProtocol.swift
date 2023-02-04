//
//  GeneriRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 03/02/23.
//

import Foundation

protocol RouterProtocols : AnyObject{
    associatedtype Router where Router: RouterProtocols
    static func createLoginModule() -> UIViewController
    func presentView(from view: UIViewController)
}

extension RouterProtocols{
    func presentView(from view: UIViewController) {
        let newView = Router.createLoginModule()
        view.present(newView, animated: true)
    }
}
