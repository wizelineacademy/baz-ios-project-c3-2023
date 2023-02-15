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
    
    class func intitTopDetail(movie: Movie?) -> UIView {
        guard let topDetail = Bundle.main.loadNibNamed("TopDetailView", owner: self, options: nil)?.first as? TopDetailView, let movie = movie else { return UIView() }
        topDetail.title.text =  movie.title
        if let partialURLBackdrop = movie.backdropPath {
            topDetail.backdrop.fetchImage(with: partialURLBackdrop)
        }
        if let partialURLPoster = movie.posterPath {
            topDetail.poster.fetchImage(with: partialURLPoster)
        }
        return topDetail
    }
}
