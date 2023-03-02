//
//  TopDetailView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class TopDetailView: UIView {
    
    @IBOutlet weak var backdrop: MovieImageView!
    @IBOutlet weak var poster: MovieImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var topInfoView: UIView!
    @IBOutlet weak var imageLayer: UIView!
    @IBOutlet weak var titleLayer: UIView!
    
    static let nibIdentifier = "TopDetailView"
    
    class func intitTopDetail(movie: Movie?) -> UIView {
        guard let topDetail = Bundle.main.loadNibNamed(TopDetailView.nibIdentifier, owner: self, options: nil)?.first as? TopDetailView, let movie = movie else { return UIView() }
        topDetail.title.text =  movie.title
        topDetail.topInfoView.layer.cornerRadius = 20
        topDetail.imageLayer.layer.cornerRadius = 15
        topDetail.poster.layer.cornerRadius = 15
        topDetail.titleLayer.layer.cornerRadius = 15
        topDetail.titleLayer.layer.maskedCorners = [.layerMaxXMinYCorner]
        if let partialURLBackdrop = movie.backdropPath {
            topDetail.backdrop.fetchImage(with: partialURLBackdrop)
        }
        if let partialURLPoster = movie.posterPath {
            topDetail.poster.fetchImage(with: partialURLPoster)
        }
        return topDetail
    }
}
