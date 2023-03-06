//
//  OverviewTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 03/03/23.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overViewText: UITextView!

    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func loadText(text: String) {
        overViewText.text = text
    }
}
