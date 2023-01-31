//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private var movies: [Movie] = []

    func getMovies() -> [Movie] {
        let remoteData = LoadRemotedata()
        let results = remoteData.loadMoviesData { result in
            print("---> \(result)")
        }
//        parseResult(from: results)
        return movies
    }
    
    func parseResult(from dataMovie:[NSDictionary]){
        
        for result in dataMovie {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String,
               let adult = result.object(forKey: "adult"),
               let backdrop_path = result.object(forKey: "backdrop_path"),
               let original_language = result.object(forKey: "original_language"),
               let original_title = result.object(forKey: "original_title"),
               let overview = result.object(forKey: "overview"),
               let media_type = result.object(forKey: "media_type"),
               let genre_ids = result.object(forKey: "genre_ids"),
               let popularity = result.object(forKey: "popularity"),
               let release_date = result.object(forKey: "release_date"),
               let video = result.object(forKey: "video"),
               let vote_average = result.object(forKey: "vote_average"),
               let vote_count = result.object(forKey: "vote_count"){
                movies.append(Movie(id: id, title: title, poster_path: poster_path, adult: adult as! Bool, backdrop_path: backdrop_path as! String, original_language: original_language as! String, original_title: original_title as! String, overview: overview as! String, media_type: media_type as! String, genre_ids: genre_ids as! [Int], popularity: popularity as! Double, release_date: release_date as! String, video: video as! Bool, vote_average: vote_average as! Double, vote_count: vote_count as! Int))
            }
        }
    }

}
