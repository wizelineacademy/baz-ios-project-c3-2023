//
//  MovieProvider.swift
//  BAZProject
//
//

import UIKit

final class MovieProvider: WSRequest {
    
    private let category: MovieCategory
    private let page: Int
    
    var viewTitle: String {
        self.category.name
    }
    
    init(category: MovieCategory, page: Int = 1) {
        self.category = category
        self.page = page
    }
    
    private func getMoviesRequest() -> URLRequest? {
        guard let url = self.category.getEndPoint(for: self.page) else { return nil }
        return URLRequest(url: url)
    }
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        sendRequest(request: getMoviesRequest()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let response: MoviesList = try self.decodeJson(from: data)
                    completion(.success(response.movies))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func set(_ cell: UITableViewCell, with movie: Movie) {
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.title.text = movie.title
            movieCell.releaseDate.text = "Lazamiento: \(movie.releaseDate ?? "")"
            movieCell.language.text = "Idioma original: \(movie.originalLanguage)"
            guard let url = movie.getPosterURL(with: 300) else { return }
            
            sendRequest(request: URLRequest(url: url)) { result in
                switch result {
                case .success(let data):
                    movieCell.posterImage.image = UIImage(data: data)
                default:
                    break
                }
            }
        }
    }
}
