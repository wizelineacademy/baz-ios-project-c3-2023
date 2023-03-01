//
//  ActorCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Michel Torres Alonso on 28/02/23.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorImageView.contentMode = .scaleAspectFill
        actorImageView.layer.cornerRadius = actorImageView.frame.width / 2
        actorImageView.layer.masksToBounds = false
        actorImageView.clipsToBounds = true
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
