//
//  MSOutputProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

protocol MSOutputProtocol: AnyObject {
    func setView(with data: MSEntity)
    func didReceive(_ movies: [Movie])
    func didReceive(_ error: Error)
    func goNext(_ viewController: UIViewController)
}
