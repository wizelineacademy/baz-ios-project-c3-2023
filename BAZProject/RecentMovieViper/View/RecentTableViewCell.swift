//
//  RecentTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    @IBOutlet weak var recentContentView: UIView!
    @IBOutlet weak var recentMovieImageView: UIImageView!
    @IBOutlet weak var degradeImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    var idMovie: Int?
    
    func setupCellImage(image: UIImage?, name: String, id: Int) {
        self.idMovie = id
        DispatchQueue.main.async {
            self.recentMovieImageView.clipsToBounds = true
            self.recentMovieImageView.layer.cornerRadius = 15.0
            self.degradeImageView.clipsToBounds = true
            self.degradeImageView.layer.cornerRadius = 15.0
            if let image = image {
                self.recentMovieImageView.image = image
            } else {
                self.recentMovieImageView.image = UIImage(named: "poster")
            }
            self.nameMovieLabel.text = name
            self.recentContentView.addShadow()
        }
    }
    
    
    @IBAction func didSelectCloseButton(_ sender: Any) {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name("DeleteRecentMovie"), object: ["idMovie": idMovie])
    }
}
