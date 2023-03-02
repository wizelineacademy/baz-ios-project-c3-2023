//
//  MLProviderProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import Foundation

protocol MLProviderProtocol: AnyObject {
    var viewTitle: String { get }
    var iconName: String { get }
    
    func update(moviesData: MoviesList, completion: @escaping (Result<MoviesList, Error>) -> Void)
}
