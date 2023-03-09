//
//  MovieListDataSource.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 09/02/23.
//

import UIKit

final class MovieListDataSource: NSObject {
    var data: MoviesList
    
    init(data: MoviesList = MoviesList()) {
        self.data = data
    }
}

extension MovieListDataSource: MLTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
        let movie = self.data.movies[indexPath.row]
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.setupCell(with: movie)
        }
        return cell
    }
}
