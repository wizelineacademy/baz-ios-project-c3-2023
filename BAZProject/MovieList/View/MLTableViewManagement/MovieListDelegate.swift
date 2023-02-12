//
//  MovieListDelegate.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 09/02/23.
//

import UIKit

protocol MovieListDelegate: UITableViewDataSource, UITableViewDelegate {
    var movies: [Movie] { get set }
    var eventHandler: MLViewOutputProtocol? { get }
}
