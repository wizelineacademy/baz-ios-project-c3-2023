//
//  MLTableViewManagement.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MLTableViewManagement: NSObject, MovieListDelegate {
    var movies: [Movie]
    weak var eventHandler: MLViewOutputProtocol?
    
    init(movies: [Movie] = [], eventHandler: MLViewOutputProtocol?) {
        self.movies = movies
        self.eventHandler = eventHandler
    }

// MARK: - Data source management
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
        let movie = movies[indexPath.row]
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.setCell(with: movie)
        }
        return cell
    }

// MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.eventHandler?.didSelect(movie)
    }
}
