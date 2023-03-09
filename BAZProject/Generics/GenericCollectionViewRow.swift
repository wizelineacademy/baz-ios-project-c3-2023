//
//  GenericCollectionViewRow.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import Foundation

protocol GenericCollectionViewRow {
    var collectionCellClass: any GenericCollectionViewCell.Type { get }
}
