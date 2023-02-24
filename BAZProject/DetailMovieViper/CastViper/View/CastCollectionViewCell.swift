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
    
    
    func setupCastImage(castImage: UIImage?){
        DispatchQueue.main.async {
            guard self.castImageView.image == nil else { return }
            self.castImageView.maskCircle(anyImage: self.castImageView.image ?? UIImage())
            if let castImage = castImage {
                self.castImageView.image = castImage
            } else {
                self.castImageView.image = UIImage(named: "poster")
            }
        }
    }
    
}
