//
//  InformationMoviesRemoteDataManager.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

class InformationMoviesRemoteDataManager: InformationMoviesRemoteDataManagerInputProtocol {
    
    // MARK: - Properties
    var remoteRequestHandler: InformationMoviesRemoteDataManagerOutputProtocol?
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    /**
     Function that calls the similar
     
     - Parameters:
       - idMovie: An integer value referencing the movie identifier.
     */
    func getMovieSimilar(idMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)&language=es") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                self.remoteRequestHandler?.pushSimilarMoviesData(similarMoviesData: result.results)
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /**
     Function that calls the Information movie
     
     - Parameters:
       - idMovie: An integer value referencing the movie identifier.
     */
    func getInformationMovie(idMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=es") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(InformationMovie.self, from: data)
                self.remoteRequestHandler?.pushInformationMovieData(movieData: result)
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
