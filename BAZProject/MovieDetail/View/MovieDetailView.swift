//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MovieDetailView: UIViewController {
    
    weak var eventHandler: MDEventHandler?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    init() {
        super.init(nibName: String(describing: MovieDetailView.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.eventHandler?.didLoadView()
    }
    
    func setView(with movie: Movie) {
        self.title = movie.title
        self.movieTitle.text = movie.title
        self.movieDescription.text = movie.overview
        self.releaseDate.text = movie.releaseDate
        self.backgroundImage.image = UIImage(named: "poster")
        
        if let imageURL = movie.getBackgroundMovieURL(with: 500) {
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
