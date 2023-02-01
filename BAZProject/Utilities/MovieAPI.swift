//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

class MovieAPI: WSRequestProtocol {
    
    private let filter: Filters
    private let page: Int
    
    var request: URLRequest? {
        guard let url = self.filter.getEndPoint(for: self.page) else { return nil }
        return URLRequest(url: url)
    }
    
    var viewTitle: String {
        self.filter.name
    }
    
    init(filter: Filters, page: Int = 1) {
        self.filter = filter
        self.page = page
    }
    
    
    /** Returns synchronously a list of movies from TheMovieDB API */
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let manager = WebServiceManager(request: self)
        manager.sendRequest { (result: Result<MoviesList, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func set(_ cell: UITableViewCell, with movie: Movie) {
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.title.text = movie.title
            movieCell.releaseDate.text = "Lazamiento: \(movie.releaseDate)"
            movieCell.language.text = "Idioma original: \(movie.originalLanguage)"
            guard let url = movie.getPosterURL(with: 300) else { return }
            
            DispatchQueue.global(qos: .utility).async {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        if let data = data {
                            movieCell.posterImage.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
