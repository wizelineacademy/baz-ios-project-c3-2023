//
//  CastCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 13/02/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    func setupCastCell(castImage: UIImage?, name: String, character: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.characterLabel.text = character
            self.castImageView.maskCircle(anyImage: self.castImageView.image ?? UIImage())
            if let castImage = castImage {
                self.castImageView.image = castImage
            } else {
                self.castImageView.image = UIImage(named: "poster")
            }
        }
    }
    
}
