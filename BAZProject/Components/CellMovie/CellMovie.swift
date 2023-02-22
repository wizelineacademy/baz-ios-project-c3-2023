//
//  CellMovie.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

class CellMovie: UITableViewCell {
    static let  identifier: String = .cellMovieXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var photoImageView: UIImageView! {
        didSet {
            let photoHeight: CGFloat = photoImageView.bounds.height
            photoImageView.layer.cornerRadius = photoHeight / LocalizedConstants.cellMovieDivisorNumberHeight
        }
    }

    @IBOutlet weak private var lblTitle: UILabel! {
        didSet {
            lblTitle.textColor = LocalizedConstants.commonSecondaryColor
            lblTitle.addShadow(.white)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(title: String, imageUrl: String) {
        lblTitle.text = title
        photoImageView.loadImage(id: imageUrl)
    }
}
