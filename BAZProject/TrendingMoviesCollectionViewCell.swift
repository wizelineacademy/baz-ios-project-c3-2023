//
//  TrendingMoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import UIKit

class TrendingMoviesCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var trendingImageView: UIImageView!
    @IBOutlet weak var titleTrendingMovieLabel: UILabel!
    let utils = Utils()
    
    
    func setupTrendingImage(urlImage: String){
        self.trendingImageView.layer.cornerRadius = 20
        self.trendingImageView.clipsToBounds = true
        if urlImage != ""{
            utils.getImage(for: urlImage) { trendingImage in
                DispatchQueue.main.async {
                    self.trendingImageView.image = trendingImage
                }
            }
        }
    }
}
