//
//  MovieProvider.swift
//  BAZProject
//
//

import Foundation

final class MovieProvider: WSRequestProtocol {
    
    private let category: MovieCategory
    
    init(category: MovieCategory) {
        self.category = category
    }
    
    /** Regresa un objeto URLRequest a partir de la categoria recibida */
    private func getMoviesRequest(with page: Int) -> URLRequest? {
        guard let url = self.category.getEndPoint(for: page) else { return nil }
        return URLRequest(url: url)
    }
}

extension MovieProvider: MLProviderProtocol {
    
    /** Regresa el título de la vista según el nombre de la categoria recibida */
    var viewTitle: String {
        self.category.name
    }
    
    /** Regresa el nombre del icono correspondiente a la categoria recibida */
    var iconName: String {
        self.category.itemName
    }
    
    /**
     Regresa de manera sincrona un listado de peliculas según la categoria y pagina guardadas
     - Parameters:
        - moviesData: un objeto de tipo MoviesList
        - completion: un closure que se llama cuando la tarea ha sido completada
     - Returns: regresa un objeto de tipo Result, en caso de un success retorna el objeto MoviesList actualizado con las nuevas peliculas, en caso contrario un error
     ````
     provider.update(moviesData: data) { [weak self] result in
         switch result {
         case .success(let data):
             ... your code on succes
         case .failure(let error):
             ... your code on error
         }
     }
     ````
     */
    func update(moviesData: MoviesList, completion: @escaping (Result<MoviesList, Error>) -> Void) {
        guard let page = moviesData.nextPage else { return completion(.failure(MSError.invalidPage)) }
        fetch(request: getMoviesRequest(with: page)) { (result: Result<PagedMovies, Error>) in
            switch result {
            case .success(let pageMovies):
                let moviesList = moviesData
                    .updatePages(currentPage: pageMovies.page, of: pageMovies.totalPages)
                    .updateMovies(with: pageMovies.movies)
                completion(.success(moviesList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
