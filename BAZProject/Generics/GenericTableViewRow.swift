//
//  GenericTableViewRow.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import Foundation

protocol GenericTableViewRow {
    var id: Int { get }
    var tableCellClass: any GenericTableViewCell.Type { get }
}
