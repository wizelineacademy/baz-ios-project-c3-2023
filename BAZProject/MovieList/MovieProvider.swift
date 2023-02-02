//
//  MovieProvider.swift
//  BAZProject
//
//

import UIKit

final class MovieProvider: WSRequest {
    
    private let category: MovieCategory
    private let page: Int
    
    /** Regresa el título de la vista según el nombre de la categoria recibida */
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
    
    /**
     Regresa de manera sincrona un listado de peliculas según la categoria y pagina guardadas
     - Parameters:
        - completion: un closure que se llama cuando la tarea ha sido completada
     - Returns: regresa un objeto de tipo Result, en caso de un success retorna un arreglo de tipo Movie, en caso contrario un error
     ````
     movieAPI.getMovies { (result: Result<[Movie], Error>) in
         switch result {
         case .success(let movies):
            ... your code on success
         case .failure(let error):
            ... your code on error
         }
     }
     ````
     */
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
    
    /**
     Intenta castear un objeto de tipo UITableViewCell a un tipo MovieTableViewCell, dicha instancia se configura a partir de un objeto de tipo Movie
     - Parameters:
        - cell: un objeto de tipo UITableViewCell
        - movie: un objeto de tipo Movie
     */
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
