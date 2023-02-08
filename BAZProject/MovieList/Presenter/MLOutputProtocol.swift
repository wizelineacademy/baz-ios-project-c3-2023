//
//  MLOutputProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

protocol MLOutputProtocol: AnyObject {
    func set(title: String)
    func didFind(movies: [Movie])
    func didFind(error: Error)
    func goNext(_ viewController: UIViewController)
}
