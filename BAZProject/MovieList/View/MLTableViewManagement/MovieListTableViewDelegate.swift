//
//  MovieListTableViewDelegate.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MovieListTableViewDelegate: NSObject {
    weak var output: MLTableViewOutputProtocol?
    
    init(output: MLTableViewOutputProtocol) {
        self.output = output
    }
}
    
extension MovieListTableViewDelegate: MLTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output?.didSelect(indexPath: indexPath)
    }
}
