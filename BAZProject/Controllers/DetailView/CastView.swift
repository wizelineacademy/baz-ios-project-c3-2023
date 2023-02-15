//
//  CastView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class CastView: UIView {
    
    @IBOutlet weak var castCollection: UICollectionView!
    
    var movieCast: [MovieCast]?
    
    class func initCastView() -> UIView {
        guard let castView = Bundle.main.loadNibNamed("CastView", owner: self, options: nil)?.first as? CastView else { return UIView() }
        return  castView
    }
    
}
