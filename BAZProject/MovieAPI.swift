//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit


class MovieAPI {

    private let apiKey: String = "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
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
    func getMovies(ofType: RequestType) -> [Movie] {
        
        guard let url = URL(string: myUrls.basePath.rawValue + ofType.rawValue + apiKey),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let posterPath = result.object(forKey: "poster_path") as? String,
               let originalTitle = result.object(forKey: "original_title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let backdropPath = result.object(forKey: "backdrop_path") as? String {
                self.movies.append(Movie(id: id, originalTitle: originalTitle, title: title, overview: overview, backdropPath: backdropPath, posterPath: posterPath))
            }
        }
        
        return movies
        
    }
    
//  Syncronous
/// This function get Syncronous an Image from a UrlString.
///
/// ```
/// getImage(from: "https://imageURL/myImageName.jpg")
/// ```
///
/// - Parameters:
///     - UrlString:  String
///
/// - Returns: `UIImage()`
    func getImage(from UrlString: String) -> UIImage {
        let urlImage = UrlString
        guard let url = URL(string: urlImage) else { return UIImage() }
        
        return UIImage(data: try! Data(contentsOf: url))  ?? UIImage()
    }
    
//    Ascyncronous
/// This function get Ascyncronous an Image from a UrlString.
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
    func downloadImage(from urlString: String) -> UIImage {
        var myImage = UIImage()
        guard let url = URL(string: urlString) else { return UIImage() }

        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)

        urlSession.dataTask(with: url) { data, response, error in
            myImage = UIImage(data: try! Data(contentsOf: url))  ?? UIImage()
        }.resume()
        
        return myImage
    }
}
