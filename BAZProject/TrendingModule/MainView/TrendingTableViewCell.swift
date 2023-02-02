//
//  TrendingTableViewCell.swift
//  BAZProject
//
//  Created by avirgilio on 30/01/23.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    let manageImgs = LoadRemotedata()
    
    @IBOutlet weak var imgImageMovie: UIImageView!
    
    @IBOutlet weak var lblMovieTitle: UILabel!{
        didSet{
            lblMovieTitle.numberOfLines = 2
            lblMovieTitle.font = UIFont(name: "ArialMT", size: 20.0)
        }
    }
    
    @IBOutlet weak var lblMovieRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func loadMoviesInfo(arrayMovies: [ResultMovie], index: IndexPath){
        
        lblMovieTitle.text = arrayMovies[index.row].title
        lblMovieRate.text = RateViewModel(movieRate: arrayMovies[index.row].voteAverage ).movieEmojiRate.rawValue
        imgImageMovie.image = manageImgs.loadImgsFromLocal(strPath: arrayMovies[index.row].posterPath)
    }
}
