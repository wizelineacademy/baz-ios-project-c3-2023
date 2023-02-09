//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    static let nib: UINib = UINib(nibName: String(describing: MovieTableViewCell.self), bundle: .main)
    static let identifier: String = "MovieCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    func setCell(with movie: Movie) {
        title.text = movie.title
        releaseDate.text = "Lazamiento: \(movie.releaseDate ?? "")"
        language.text = "Idioma original: \(movie.originalLanguage)"
        guard let url = movie.getPosterURL(size: .medium) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    self?.posterImage.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}
