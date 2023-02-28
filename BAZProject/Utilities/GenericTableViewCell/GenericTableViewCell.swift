//
//  GenericTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 27/02/23.
//

import UIKit

class GenericTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: GenericTableViewCell.self)

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
}
