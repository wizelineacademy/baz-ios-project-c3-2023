//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

import UIKit

class CVMovieApiManager {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    
    
    func getMovies(completion: @escaping (CVMovieHubViewEntity) -> Void) {
        let urlString = "https://api.themoviedb.org/3/"
            + "trending/movie/day?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(CVMovieHubViewEntity(configuration: []))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(CVMovieHubViewEntity(configuration: []))
                return
            }
            do {
                let decoder = JSONDecoder()
                print(String(data: data, encoding: .utf8) ?? "")
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(CVMovieApiResponse.self, from: data)                
                let trendingMovies = response.results.map { CVMovieHubViewEntityMovieItem(
                    image: $0.poster_path ?? "",
                    title: $0.title ?? "",
                    rating: Int(($0.vote_average ?? 0) * 10),
                    description: $0.overview ?? ""
                )}
                let nowPlayingMovies = self.getMoviesFromApi(endpoint: "movie/now_playing")
                let popularMovies = self.getMoviesFromApi(endpoint: "movie/popular")
                let topRatedMovies = self.getMoviesFromApi(endpoint: "movie/top_rated")
                let upcomingMovies = self.getMoviesFromApi(endpoint: "movie/upcoming")
                let configuration = [
                    CVMovieHubViewEntitySection(
                        sectionName: "Trending",
                        availableMovies: trendingMovies
                    ),
                    CVMovieHubViewEntitySection(
                        sectionName: "Now Playing",
                        availableMovies: nowPlayingMovies
                    ),
                    CVMovieHubViewEntitySection(
                        sectionName: "Popular",
                        availableMovies: popularMovies
                    ),
                    CVMovieHubViewEntitySection(
                        sectionName: "Top Rated",
                        availableMovies: topRatedMovies
                    ),
                    CVMovieHubViewEntitySection(
                        sectionName: "Upcoming",
                        availableMovies: upcomingMovies
                    )
                ]
                completion(CVMovieHubViewEntity(configuration: configuration))
            } catch {
                print(error.localizedDescription)
                completion(CVMovieHubViewEntity(configuration: []))
            }
        }
        task.resume()
    }

    private func getMoviesFromApi(endpoint: String) -> [CVMovieHubViewEntityMovieItem] {
        let urlString = "https://api.themoviedb.org/3/"
            + "\(endpoint)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            print(String(data: data, encoding: .utf8) ?? "")            
            let response = try decoder.decode(CVMovieApiResponse.self, from: data)
            return response.results.map { CVMovieHubViewEntityMovieItem(
                image:  $0.poster_path ?? "",
                title: $0.title ?? "",
                rating: Int(($0.vote_average ?? 0) * 10),
                description: $0.overview ?? ""
            )}
        } catch {
            print(error.localizedDescription)
            return []
        }
    }


}


