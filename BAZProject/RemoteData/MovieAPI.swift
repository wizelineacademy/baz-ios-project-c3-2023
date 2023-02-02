//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private var movies: [ResultMovie] = []

    func getMovies(completion: @escaping(Result<[ResultMovie],Error>) -> Void)  {
        let remoteData = LoadRemotedata()
        let endPoint = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        remoteData.get(endPoint, MovieModel.self) { result in
            switch result {
            case .success(let objMovies):
                if objMovies.results.count > 0 {
                    completion(.success(objMovies.results))
                }
            case .failure(_):
                print("Error")
            }
        }
    }

}
