//
//  MovieListView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class MovieListView: UIView {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var sectionLayer: UIView!
    
    class func initMovieCollection() -> UIView {
        guard let movieCollection =  Bundle.main.loadNibNamed("MovieListView", owner: self, options: nil)?.first as? MovieListView else { return UIView() }
        movieCollection.sectionLayer.layer.cornerRadius = 15
        movieCollection.sectionLayer.layer.maskedCorners = [.layerMaxXMinYCorner]
        return movieCollection
    }
    
}
