//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit


class MovieAPI {

    private let apiKey: String = "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    var searchText: String = ""
    var movies = [Movie]()
    
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
        if ofType == .search {
            myURL += "&query=" + ( searchText.addingPercentEncoding( withAllowedCharacters: .urlHostAllowed ) ?? "")
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
               let overview = result.object(forKey: "overview") as? String {
                self.movies.append(Movie(id: id, originalTitle: originalTitle, title: title, overview: overview, posterPath: posterPath))
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
}
