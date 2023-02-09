//
//  MSProvider.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSProvider: WSRequestProtocol, MSProviderProtocol {
    func getViewData() -> MSEntity {
        MSEntity(viewTitle: "Buscar", itemsForRow: 3)
    }
    
    func getMovies(by text: String?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let text = text,
              !text.isEmpty
        else { return completion(.success([])) }
        
        guard let baseURL = MovieAPI.getBaseURL(queryItems: ["query": text])
        else { return completion(.failure(MSError.invalidURL)) }
        
        let url = baseURL.appendingPathComponent("/search/movie")
        let request = URLRequest(url: url)
        fetch(request: request) { (result: Result<MoviesList, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.movies))
            case .failure(_):
                break
            }
        }
    }
    
    func getNextViewController(with movie: Movie) -> UIViewController {
        MDRouter.getEntry(with: movie)
    }
}
