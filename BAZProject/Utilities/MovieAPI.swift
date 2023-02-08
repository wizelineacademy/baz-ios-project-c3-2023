//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

public enum URLApi {
    private var apiKey: String { "f6cd5c1a9e6c6b965fdcab0fa6ddd38a" }
    private var urlBase: String { "https://api.themoviedb.org/3" }
    
    case upcoming
    case Trending(page: Int)
    case nowPlaying(page: Int)
    case Popular(page: Int)
    case topRated(page: Int)
    case keyword(query:String)
    case searchMovie(query:String, page: Int)
    case reviews(movieId:String)
    case similar(movieId:String)
    case recommendations(movieId:String)
    
    var URL: String{
        switch self {
        case .upcoming:
            return "\(urlBase)/movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1"
        case .Trending(let page):
            return "\(urlBase)/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=\(page)"
        case .nowPlaying(let page):
            return "\(urlBase)/movie/now_playing?api_key=\(apiKey)&language=es&region=MX&page=\(page)"
        case .Popular(let page):
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
        }
    }
}

final class MovieAPI {
    private let imgBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    public var getMultipleDataMovies: [Codable]?
    public var getDataMovies: Codable?
    /**    func to help to get Data of apis
     - Parameter url: url of api
     
     */
    func getApiData(from url:URLApi, handler: @escaping (Data) -> Void){
        guard let url = URL(string: url.URL) else{return}
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else{return}
            handler(datos)
        }
        task.resume()
    }
    
    /**    func to help to get a image

    - Parameter imageUrl: url of image

    */
    func getImage(from imageUrl:String, handler: @escaping (UIImage) -> Void){
        let url = URL(string: "\(imgBaseUrl)\(imageUrl)")
        guard let url = url else {return}
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            handler(image)
        }
    }
}
