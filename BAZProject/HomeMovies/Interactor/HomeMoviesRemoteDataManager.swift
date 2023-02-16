//
//  HomeMoviesRemoteDataManager.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

class HomeMoviesRemoteDataManager: HomeMoviesRemoteDataManagerInputProtocol {
    
    // MARK: - Properties
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol?
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    /**
     Function that calls the get method
     
     - Parameters:
       - categoryMovieType: A categoryMovieType value referencing the type of category to consult.
     */
    func getMovies(categoryMovieType category: MovieCategory) {
        guard let url = URL(string: "https://api.themoviedb.org/3\(category.endpoint)?api_key=\(apiKey)&language=es&page=1") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                self.remoteRequestHandler?.pushMoviesData(moviesData: result.results)
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }

    /**
     Function that calls the searchMult
     
     - Parameters:
       - searchTerm: A string value referencing the query term in te data base of themoviedb.
     */
    func getSearchedMovies(searchTerm query: String) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&language=es&query=\(query)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieResult.self, from: data)
                self.remoteRequestHandler?.pushSearchedMoviesData(moviesData: result.results.filter({$0.media_type == "movie"}))
            }catch {
                self.remoteRequestHandler?.catchResponse(withMessage: "error: \(error.localizedDescription)")
            }
        }.resume()
    }

    /**
     Function that calls the detailMovie
     
     - Parameters:
       - idMovie: An integer value referencing the movie identifier.
     */
    func getInformationMovie(idMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=es&page=1") else { return }
        
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
