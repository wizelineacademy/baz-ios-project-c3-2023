//
//  ActorCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Michel Torres Alonso on 28/02/23.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorShadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    
    private func setupImageView() {
        // Made the image like a circle.
        actorImageView.contentMode = .scaleAspectFill
        actorImageView.layer.cornerRadius = actorImageView.frame.width / 2
        actorImageView.layer.masksToBounds = true
        actorImageView.clipsToBounds = true
        
        // Add a shadow to UIImageView, the UIImageView must have a container view.
        actorShadowView.clipsToBounds = false
        actorShadowView.layer.cornerRadius = actorShadowView.frame.width / 2
        actorShadowView.layer.masksToBounds = false
        actorShadowView.layer.shadowColor = UIColor.gray.cgColor
        actorShadowView.layer.shadowOpacity = 1
        actorShadowView.layer.shadowOffset = CGSize.zero
        actorShadowView.layer.shadowRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        characterLabel.text = nil
        actorImageView.image = nil
    }
    
    func setup(cast: Cast) {
        nameLabel.text = cast.name
        characterLabel.text = cast.character
        actorImageView.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")")
    }
}
