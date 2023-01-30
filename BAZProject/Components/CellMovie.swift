//
//  CellMovie.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

class CellMovie: UITableViewCell {
    
    static let  identifier = "CellMovie"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        }
    }

    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.layer.shadowOffset = CGSize(width: 0, height: 1)
            lblTitle.layer.shadowOpacity = 0.3
            lblTitle.layer.cornerRadius = 10
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
