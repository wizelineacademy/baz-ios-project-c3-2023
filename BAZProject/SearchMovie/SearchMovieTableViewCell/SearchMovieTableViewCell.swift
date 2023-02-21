//
//  SearchMovieTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 20/02/23.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReview: UILabel!
    
    //MARK: Properties
    static let identifier = "SearchMovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier , bundle: nil)
    }
    
    /// Funcion que nos permite configurar la infomración de la celda
    /// - Parameter model: Model Movie para llenar la vista de la celda
    public func configure(withModel model : Movie) {
        self.lblMovieTitle.text = model.title
        self.lblMovieReview.text = model.overview
        if model.posterPath == nil {
            self.imgMoviePoster.image = UIImage(named: "poster")
        }else{
            if let url = URL(string: model.posterImagefullPath) {
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        self.imgMoviePoster.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
