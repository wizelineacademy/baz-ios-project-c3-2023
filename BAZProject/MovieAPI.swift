//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit


class MovieAPI {

    private let apiKey: String = "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    var movies = [Movie]()
    
    func getMovies(request: RequestType) -> [Movie] {
        
        guard let url = URL(string: myUrls.basePath.rawValue + request.rawValue + apiKey),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String,
               let original_title = result.object(forKey: "original_title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let backdrop_path = result.object(forKey: "backdrop_path") as? String {
                self.movies.append(Movie(id: id, original_title: original_title, title: title, overview: overview, backdrop_path: backdrop_path, poster_path: poster_path))
            }
        }
        
        return movies
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
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
