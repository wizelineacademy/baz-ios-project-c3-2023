//
//  MSEventHandler.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

protocol MSEventHandler: AnyObject {
    func didLoadView()
    func seakMovies(by text: String?)
    func didSelect(_ movie: Movie)
}
