//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let language: String = "language=es"
    private let region = "region=MX"

    /// Consult the list of movies bye category in Mexico region and in spanish laguague.
    ///
    ///  - Parameter category: The category to be consulted
    ///  - Returns: [Movie]
    ///

    func getMovies(category: MovieAPICategory) -> [Movie] {
        guard let urlTrendingMovies = URL(string: "https://api.themoviedb.org/3/\(category.rawValue)?api_key=\(apiKey)&\(language)&\(region)"),
              let data = try? Data(contentsOf: urlTrendingMovies),
              let json = try? JSONDecoder().decode(MovieAPIResult.self, from: data)
        else {
            return []
        }
        return json.results
    }
    
    /// Fetch movie poster with completion handler
    ///
    ///  - Parameter url: The given image URL
    ///  - Returns: UIImage.
    ///
    
    static func fetchPhoto(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completionHandler(nil, error)
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                if let imageToShow = UIImage(data: data){
                    DispatchQueue.main.async {
                        completionHandler(imageToShow,nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completionHandler(UIImage(named: "poster"),nil)
                    }
                }
            }
        }
        task.resume()
    }
    
}
