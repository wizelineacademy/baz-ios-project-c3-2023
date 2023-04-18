//
//  CVCarouselItemCollectionViewCell.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 17/04/23.
//

import UIKit
import Foundation

class CVCarouselItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!
    
    var parentVC:UIViewController? = nil
    
    var item:CVMovieHubViewEntityMovieItem? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add tap gesture recognizer to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    func tryDrawImage(url:String) {
        CVCacheImageManager.tryFetchImageAsync(completion: { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }, fromURL: url)
    }

    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let imageViewFrame = self.imageView.superview?.convert(self.imageView.frame, to: window)
        else { return }
        
        // Create a new fullscreen image view
        let fullscreenImageView = UIImageView(image: self.imageView.image)
        fullscreenImageView.contentMode = .scaleAspectFit
        fullscreenImageView.frame = imageViewFrame
        window.addSubview(fullscreenImageView)
        // Animate the fullscreen image view
        UIView.animate(withDuration: 0.3, animations: {
            fullscreenImageView.frame = window.frame
        }) { _ in
            
            if let actualItem = self.item {
                // Create and present the detail view controller
                let detailViewController = MovieDetailRouter.createModule(previusImage: self.imageView.image, movie: actualItem)
                detailViewController.view.backgroundColor = .clear
                detailViewController.modalPresentationStyle = .overCurrentContext
                detailViewController.modalTransitionStyle = .crossDissolve
                let imageView = UIImageView(image: self.imageView.image)
                imageView.contentMode = .scaleAspectFit
                detailViewController.view.addSubview(imageView)
                imageView.frame = window.frame
                if let parentVC = window.rootViewController {
                    parentVC.present(detailViewController, animated: true) {
                        fullscreenImageView.alpha = 0
                        UIView.animate(withDuration: 0.2, animations: {
                            imageView.frame.origin.y -= 150
                            let scaleTransform = CGAffineTransform(scaleX: 2, y: 2)
                            imageView.transform = scaleTransform
                        }, completion: { _ in
                            fullscreenImageView.removeFromSuperview()
                        })
                    }
                }

            }
        }
    }



}
