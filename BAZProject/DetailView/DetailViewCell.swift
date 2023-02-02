//
//  DetailViewCell.swift
//  BAZProject
//
//  Created by avirgilio on 27/01/23.
//

import UIKit

enum DetailTrendingConstants{
    static let cellTitleMovie = "Título"
    static let cellReleaseMovie = "Fecha Estreno"
    static let cellOverviesMovie = "Sinopsis"
}

class DetailViewCell: UITableViewCell {

    
    private typealias Constants = DetailTrendingConstants
    
    @IBOutlet weak var lblElementName: UILabel!{
        didSet{
            lblElementName.text = ""
            lblElementName.font = UIFont(name: "ArialHebrew-Bold", size: 20.0)
        }
    }
    
    @IBOutlet weak var lblElementValue: UILabel!{
        didSet{
            lblElementValue.numberOfLines = 10
            lblElementValue.font = UIFont(name: "ArialMT", size: 20.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadMovieInfo(objectMovie: ResultMovie, index: IndexPath){
        switch index.row {
        case 0:
            lblElementName.text = Constants.cellTitleMovie
            lblElementValue.text = objectMovie.originalTitle
        case 1:
            lblElementName.text = Constants.cellReleaseMovie
            lblElementValue.text = objectMovie.releaseDate
        case 2:
            lblElementName.text = Constants.cellOverviesMovie
            lblElementValue.text = objectMovie.overview
        default:
            lblElementName.text = "N/A"
            lblElementValue.text = "N/A"
        }
    }
    
}
