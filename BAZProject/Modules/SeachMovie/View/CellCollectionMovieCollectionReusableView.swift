//
//  CellCollectionMovieCollectionReusableView.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 17/02/23.
//

import UIKit

class CellCollectionMovieCollectionReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    func setupCell(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.imageMovie.image = image
            self.nameMovie.text = title
        }
    }
    
}
