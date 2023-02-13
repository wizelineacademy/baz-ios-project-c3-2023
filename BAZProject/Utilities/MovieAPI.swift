//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

public enum URLApi: Hashable {
    
    private var apiKey: String { "f6cd5c1a9e6c6b965fdcab0fa6ddd38a" }
    private var urlBase: String { "https://api.themoviedb.org/3" }
    
    case upcoming
    case trending(page: Int)
    case nowPlaying(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case keyword(query: String)
    case searchMovie(query: String, page: Int)
    case reviews(movieId: String)
    case similar(movieId: String)
    case recommendations(movieId: String)
    case creditMovie(movieId: String)
    
    var URL: String {
        switch self {
        case .upcoming:
            return "\(urlBase)/movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1"
        case .trending(let page):
            return "\(urlBase)/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=\(page)"
        case .nowPlaying(let page):
            return "\(urlBase)/movie/now_playing?api_key=\(apiKey)&language=es&region=MX&page=\(page)"
        case .popular(let page):
            return "\(urlBase)/movie/popular?api_key=\(apiKey)&language=es&region=MX&page=\(page)"
        case .topRated(let page):
            return "\(urlBase)/movie/top_rated?api_key=\(apiKey)&language=es&page=\(page)&region=MX"
        case .keyword(let query):
            return "\(urlBase)/search/keyword?api_key=\(apiKey)&language=es&query=\(query)"
        case .searchMovie(let query, let page):
            return "\(urlBase)/search/movie?api_key=\(apiKey)&language=es&page=\(page)&query=\(query)"
        case .reviews(let movieId):
            return "\(urlBase)/movie/\(movieId)/reviews?api_key=\(apiKey)&language=es"
        case .similar(let movieId):
            return "\(urlBase)/movie/\(movieId)/similar?api_key=\(apiKey)&language=es"
        case .recommendations(let movieId):
            return "\(urlBase)/movie/\(movieId)/recommendations?api_key=\(apiKey)&language=es"
        case .creditMovie(let movieId):
            return "\(urlBase)/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US"
        }
    }
}

final class MovieAPI {
    static private let imgBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    
    /**    func to help to get Data of apis
     - Parameter url: url of api
     
     */
    static func getApiData(from url:URLApi, handler: @escaping (Data) -> Void) {
       guard let url = URL(string: url.URL) else { return }
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else { return }
            handler(datos)
        }
        task.resume()
    }
    
    /**    func to help to get a image

    - Parameter imageUrl: url of image

    */
    static func getImage(from imageUrl: String, handler: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .default).async {
            guard let url = URL(string: "\(imgBaseUrl)\(imageUrl)") else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else {return}
                guard let image = UIImage(data: data) else { return }
                handler(image)
            }
        }
    }
}
