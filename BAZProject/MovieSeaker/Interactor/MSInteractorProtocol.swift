//
//  MSInteractorProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

protocol MSInteractorProtocol: AnyObject {
    var output: MSOutputProtocol? { get set }
    
    func fetchViewData()
    func fetchMovies(by text: String?)
    func check(_ movie: Movie)
}
