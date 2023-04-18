//
//  MovieHeaderCollectionReusableView.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 16/04/23.
//

import UIKit

class MovieHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "MovieHeaderCollectionReusableView"
        
    @IBOutlet weak var headerLabel :UILabel!
    
    var headerTitle:String = "" {
        didSet {
            debugPrint(headerTitle)
            headerLabel.text = headerTitle
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add your header view content here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
