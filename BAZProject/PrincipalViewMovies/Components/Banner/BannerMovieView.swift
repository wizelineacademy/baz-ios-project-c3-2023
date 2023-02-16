//
//  BannerMovieVIew.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class BannerMovieView: UIView {
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIForView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUIForView()
    }
    
    private func setUIForView() {
        let bundleCustomBannerView = Bundle(for: BannerMovieView.self)
        let view = UINib(nibName: "BannerMovieView",
                         bundle: bundleCustomBannerView).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    func setImageBanner(nameAsset image: UIImage) {
        imageBanner.image = image
    }
}
