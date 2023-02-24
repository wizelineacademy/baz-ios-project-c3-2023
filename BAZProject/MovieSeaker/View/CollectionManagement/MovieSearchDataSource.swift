//
//  MovieSearchDataSource.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 17/02/23.
//

import UIKit

final class MovieSearchDataSource: NSObject {
    var movies: [Movie]
    
    init(movies: [Movie] = []) {
        self.movies = movies
    }
}

extension MovieSearchDataSource: MSCollectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MSMovieCollectionViewCell.identifier,
            for: indexPath
        )
        if let movieCell = cell as? MSMovieCollectionViewCell {
            let movie = movies[indexPath.row]
            movieCell.setupCell(with: movie)
        }
        return cell
    }
}
