//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MovieDetailView: UIViewController {
    
    var output: MDViewOutputProtocol?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.output?.didLoadView()
    }
}

extension MovieDetailView: MDViewInputProtocol {
    func setView(with movie: Movie) {
        self.title = movie.title
        self.movieTitle.text = movie.title
        self.movieDescription.text = movie.overview
        self.releaseDate.text = movie.releaseDate
        self.backgroundImage.image = UIImage(named: "poster")
        
        if let imageURL = movie.getBackgroundMovieURL(size: .huge) {
            let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, _) in
                DispatchQueue.main.async {
                    if let data = data {
                        self?.backgroundImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}
