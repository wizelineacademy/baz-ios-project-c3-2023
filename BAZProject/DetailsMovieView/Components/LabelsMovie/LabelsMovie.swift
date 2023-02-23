//
//  LabelsMovie.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

/**
 Show characteristics for each movie details like language, is for adults...
 */

final class LabelsMovie: UIView {
    
    @IBOutlet weak var lblIsAdult: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIForView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUIForView()
    }
    
    private func setUIForView() {
        let bundleCustomLabelsView = Bundle(for: LabelsMovie.self)
        let view = UINib(nibName: "LabelsMovie",
                         bundle: bundleCustomLabelsView).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
}
