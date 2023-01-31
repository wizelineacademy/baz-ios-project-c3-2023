//
//  HomeMoviesRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation

class HomeMoviesRemoteDataManager:HomeMoviesRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol?
    
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func getTrendingMovies() {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(self.apiKey)"),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
               let results = json.object(forKey: "results") as? [NSDictionary], results.count > 0{
                do{
                    let movieData = try JSONSerialization.data(withJSONObject: results, options: [])
                    let movieDecode = try? JSONDecoder().decode([Movie].self, from: movieData)
                    let movies = movieDecode ?? [Movie]()
                    self.remoteRequestHandler?.pushTrendingMovieInfo(trendingMovies: movies)
                }catch{}
            }
        }
    }
}
