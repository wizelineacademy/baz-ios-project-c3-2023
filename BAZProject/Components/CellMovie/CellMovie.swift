//
//  CellMovie.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

enum AccesoryType {
    case eye, eyeFill
}

class CellMovie: UITableViewCell {
    static let  identifier: String = .cellMovieXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var photoImageView: UIImageView! {
        didSet {
            photoImageView.addRounding()
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

    func addAccessoryView(accesory: AccesoryType) {
        var checkImage: UIImage
        var color: UIColor
        switch accesory {
        case .eye:
            checkImage = UIImage(systemName: "eye") ?? UIImage()
            color = .white
        case .eyeFill:
            checkImage = UIImage(systemName: "eye.fill") ?? UIImage()
            color = LocalizedConstants.commonSecondaryColor
        }
        let checkmark: UIImageView = UIImageView(image: checkImage)
        checkmark.tintColor = color
        self.accessoryView = checkmark
    }
}
