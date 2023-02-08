//
//  MovieProvider.swift
//  BAZProject
//
//

import Foundation

final class MovieProvider: WSRequestProtocol {
    
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
    
    /** Regresa un objeto URLRequest a partir de la categoria recibida */
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
        fetch(request: getMoviesRequest()) { [weak self] result in
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
}
