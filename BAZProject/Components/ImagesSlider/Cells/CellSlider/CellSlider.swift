//
//  CellSlider.swift
//  BAZProject
//
//  Created by 1058889 on 16/02/23.
//

import UIKit

final class CellSlider: UICollectionViewCell {
    static let  identifier: String = .cellSliderXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(imageUrl: String) {
        photoImageView.loadImage(id: imageUrl)
    }
}
