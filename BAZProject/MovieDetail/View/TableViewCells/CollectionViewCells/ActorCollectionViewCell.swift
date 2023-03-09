//
//  ActorCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class ActorCollectionViewCell: UICollectionViewCell {
    
    static var nib: UINib = UINib(nibName: String(describing: ActorCollectionViewCell.self), bundle: .main)
    static var identifier: String = String(describing: ActorCollectionViewCell.self)

    @IBOutlet private weak var actorImage: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var character: UILabel!
    
}

extension ActorCollectionViewCell: GenericCollectionViewCell {
    
    /// Configures cell properties with the given data
    /// - Parameter model: a GenericCollectionViewRow object
    func setupCell(with model: GenericCollectionViewRow) {
        guard let actor = model as? Actor else { return }
        self.name.text = actor.name
        self.character.text = actor.character
        self.actorImage.image = UIImage(named: "poster")

        guard let url = actor.getImageURL() else { return }
        ImageCache.shared.getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.actorImage.image = image
            default:
                break
            }
        }
    }
}
