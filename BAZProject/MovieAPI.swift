//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit


class MovieAPI {
    
    private let apiKey: String = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en-US"
    var searchText: String = ""
    var movies = [Movie]()
    var casting = [Casting]()
    var movieID = Int()
    var page = 1
    
/// This function make a peticion to the MovieAPI to get an array of `movies` depending on `RequestType`.
///
/// ```
/// getMovies(ofType: RequestType.type) // Example:  (RequestType.trending)
/// ```
///
/// - Parameters:
///     - .ofType: RequestType.type
///
/// - Returns:
///     - An array of `movies`. [Movie]
///
    
    func getMovies(ofType: RequestType) -> [Movie] {
        var myURL = myUrls.basePath.rawValue + ofType.rawValue + apiKey
        switch ofType {
            case .search:
                myURL += "&query=" + ( searchText.addingPercentEncoding( withAllowedCharacters: .urlHostAllowed ) ?? "")
            case .recommended, .similar :
                myURL = myUrls.moviePath.rawValue + String(movieID) + ofType.rawValue + apiKey
            default: break
        }
        if page > 0 {
            myURL += "&page=" + String(page)
        }
        
        guard let url = URL(string: myURL ),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        movies = []
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let posterPath = result.object(forKey: "poster_path") as? String,
               let originalTitle = result.object(forKey: "original_title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let genres = result.object(forKey: "genre_ids") as? [Int] {
                self.movies.append(Movie(id: id, originalTitle: originalTitle, title: title, overview: overview, posterPath: posterPath, genre_ids: genres))
            }
        }
        
        return movies
        
    }
        
/// This function an Image from a UrlString.
///
/// ```
/// downloadImage(from: "https://imageURL/myImageName.jpg")
/// ```
///
/// - Parameters:
///     - UrlString:  String
///
/// - Returns: `UIImage()`
///
    
    func downloadImage (from url: URL) -> UIImage {
        guard let data = try? Data(contentsOf: url) else { return UIImage() }
        guard  let image = UIImage (data: data) else { return UIImage() }
        return image
    }
    
    func getCasting() -> [Casting] {
        let myURL = myUrls.moviePath.rawValue + String(movieID) + RequestType.casting.rawValue + apiKey
        
        guard let url = URL(string: myURL ),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "cast") as? [NSDictionary]
        else {
            return []
        }
        casting = []
        for result in results {
            if let name = result.object(forKey: "name") as? String,
               let profile_path = result.object(forKey: "profile_path") as? String {
                self.casting.append(Casting(name: name, profile_path: profile_path))
            }
        }
        
        return casting
    }
}
