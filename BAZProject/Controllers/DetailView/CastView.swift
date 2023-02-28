//
//  CastView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class CastView: UIView {
    
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var sectionLayer: UIView!
    
    var movieCast: [MovieCast]?
    
    class func initCastView() -> UIView {
        guard let castView = Bundle.main.loadNibNamed("CastView", owner: self, options: nil)?.first as? CastView else { return UIView() }
        castView.sectionLayer.layer.cornerRadius = 15
        castView.sectionLayer.layer.maskedCorners = [.layerMaxXMinYCorner]
        return  castView
    }
    
}
