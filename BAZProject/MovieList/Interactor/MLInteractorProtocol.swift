//
//  MLInteractorProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import Foundation

protocol MLInteractorProtocol: AnyObject {
    var output: MLOutputProtocol? { get set }
    func fetchData()
    func check(movie: Movie)
}
