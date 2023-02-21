//  CellMovieTop.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 20/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CellMovieTop: UICollectionViewCell {
    static let  identifier: String = .cellMovieTopXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(cellMovieType: CellMovieType) {
        photoImageView.loadImage(id: cellMovieType.imageUrlString)
    }
}
