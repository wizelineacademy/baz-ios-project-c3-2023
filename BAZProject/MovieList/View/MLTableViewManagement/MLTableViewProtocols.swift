//
//  MLTableViewProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 16/02/23.
//

import UIKit

protocol MLTableViewDataSource: UITableViewDataSource {
    var data: MoviesList { get set }
}

extension MLTableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

protocol MLTableViewDelegate: UITableViewDelegate {
    var output: MLTableViewOutputProtocol? { get }
}

protocol MLTableViewOutputProtocol: AnyObject {
    func didSelect(indexPath: IndexPath)
}
