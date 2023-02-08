//
//  MLProviderProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

protocol MLProviderProtocol: AnyObject {
    var viewTitle: String { get }
    var iconName: String { get }
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getNextViewController(for movie: Movie) -> UIViewController
}
