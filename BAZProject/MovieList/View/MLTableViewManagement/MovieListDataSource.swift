//
//  MovieListDataSource.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 09/02/23.
//

import UIKit

final class MovieListDataSource: NSObject {
    var movies: [Movie]
    
    init(movies: [Movie] = []) {
        self.movies = movies
    }
}

extension MovieListDataSource: MLTableViewDataSource {
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
            movieCell.setupCell(with: movie)
        }
        return cell
    }
}
