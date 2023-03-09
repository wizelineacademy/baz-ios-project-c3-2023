//
//  DetailTableViewProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import UIKit

protocol DetailDataSource: UITableViewDataSource {
    var rows: [any GenericTableViewRow] { get set }
}

extension DetailDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

protocol DetailTableViewDelegate: UITableViewDelegate {
    var output: DetailDelegateOutput { get set }
}

protocol DetailDelegateOutput: AnyObject {
    func didSelectRow(at indexPath: IndexPath)
}

protocol SliderMovieDelegate: AnyObject {
    func didSelect(_ movie: Movie)
}
