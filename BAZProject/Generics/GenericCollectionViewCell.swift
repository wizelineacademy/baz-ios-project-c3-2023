//
//  GenericCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

protocol GenericCollectionViewCell: UICollectionViewCell where Model == GenericCollectionViewRow {
    associatedtype Model
    
    static var nib: UINib { get }
    static var identifier: String { get }
    
    func setupCell(with model: Model)
}
