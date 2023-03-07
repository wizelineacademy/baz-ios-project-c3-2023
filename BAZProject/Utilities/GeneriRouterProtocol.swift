//
//  GeneriRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 03/02/23.
//

import UIKit

protocol RouterProtocols: AnyObject {
    associatedtype Router where Router: RouterProtocols
    static func createModule() -> UIViewController
    func presentView(from view: UIViewController)
}

extension RouterProtocols{
    func presentView(from view: UIViewController) {
        let newView = Router.createModule()
        view.navigationController?.pushViewController(newView, animated: true)
    }
}

protocol RouterCreateModuleWithDataProtocol: AnyObject {
    static func createModule<T>(data: T) -> UIViewController
}

protocol RouterPresentViewWithDataProtocol: AnyObject {
    associatedtype RouterWithData where RouterWithData: RouterCreateModuleWithDataProtocol
    func presentView<T>(from view: UIViewController, data: T)
}

extension RouterPresentViewWithDataProtocol {
    func presentView<T>(from view: UIViewController, data: T) {
        let newView = RouterWithData.createModule(data: data)
        view.navigationController?.pushViewController(newView, animated: true)
    }
}
