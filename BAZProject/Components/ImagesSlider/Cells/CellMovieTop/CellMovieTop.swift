//  CellMovieTop.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 20/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// This class allows you to create a cell with a image and a title.
///
/// :conditions: The methods it has are those declared in the class 'CellMovieTop':
/// * func setData
///
final class CellMovieTop: UICollectionViewCell {
    static let  identifier: String = .cellMovieTopXibIdentifier
    /// This function allows to get the UINib of the cell.
    /// Way to call CellMovieTop.nib()
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: - Declaration IBOutlets
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// This function allows you to configure the cell, where you must indicate the cellMovieType.
    ///
    /// :param: cellMovieType CellMovieType indicating the CellMovieType
    func setData(cellMovieType: CellMovieType) {
        photoImageView.loadImage(id: cellMovieType.imageUrlString)
        titleLabel.text = cellMovieType.title
    }
}
