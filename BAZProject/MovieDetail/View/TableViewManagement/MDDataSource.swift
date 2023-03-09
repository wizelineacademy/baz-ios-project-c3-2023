//
//  MDDataSource.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import UIKit

final class MDDataSource: NSObject {
    var rows: [any GenericTableViewRow]
    private weak var delegate: SliderMovieDelegate?
    
    init(rows: [any GenericTableViewRow] = [], delegate: SliderMovieDelegate?) {
        self.rows = rows
        self.delegate = delegate
    }
}

extension MDDataSource: DetailDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.tableCellClass.identifier, for: indexPath)
        if let detailCell = cell as? any GenericTableViewCell {
            detailCell.setupCell(with: row)
            (detailCell as? SliderTableViewCell)?.eventHandler = delegate
        }
        return cell
    }
}
