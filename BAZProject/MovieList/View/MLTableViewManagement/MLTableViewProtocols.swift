//
//  MLTableViewProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 16/02/23.
//

import UIKit

protocol MLTableViewDataSource: UITableViewDataSource {
    var movies: [Movie] { get set }
}

protocol MLTableViewDelegate: UITableViewDelegate {
    var output: MLTableViewOutputProtocol? { get }
}

protocol MLTableViewOutputProtocol: AnyObject {
    func didSelect(indexPath: IndexPath)
}
