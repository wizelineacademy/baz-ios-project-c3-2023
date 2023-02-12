//
//  MSProvider.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSProvider: WSRequestProtocol, MSProviderProtocol {
    /**
     Create an object with the view title and number of items per row
     - Returns: a MSEntity object
     */
    func getViewData() -> MSEntity {
        MSEntity(viewTitle: "Buscar", itemsForRow: 3)
    }
    
    /**
     Create a URLRequest object with the base url to search a movie by the received string
     - Parameters:
        - text: a string used to search a movie
        - completion: a closure that it's called when the task is completed
     - Returns: a Result object that, when on success case returns a movie array, otherwise an error object
     */
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
}
