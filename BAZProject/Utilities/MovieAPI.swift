//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

public enum URLApi: Hashable {
    
    case upcoming
    case trending
    case nowPlaying
    case popular
    case topRated
    case keyword
    case searchMovie
    case reviews
    case similar
    case recommendations
    case creditMovie
    case nothing
    case movie
    
    var getEndpointUrl: String {
        switch self {
        case .upcoming:
            return "/3/movie/upcoming"
        case .trending:
            return "/3/trending/movie/day"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .keyword:
            return "/3/search/keyword"
        case .searchMovie:
            return "/3/search/movie"
        case .reviews:
            return "/reviews"
        case .similar:
            return "/similar"
        case .recommendations:
            return "/recommendations"
        case .creditMovie:
            return "/credits"
        default: return ""
        }
    }
    
    public func indexForSectionMain(for IndexpathValue: Int) -> URLApi? {
        switch IndexpathValue {
        case 0: return .trending
        case 1: return .nowPlaying
        case 2: return .popular
        case 3: return .topRated
        case 4: return .upcoming
        default: return nil
        }
    }
    
    public func setTitleForSection(for indexPathValue: Int) -> String? {
        switch indexPathValue {
        case 0: return "Tendencia"
        case 1: return "En cines"
        case 2: return "Popular"
        case 3: return "Mejor valoradas"
        case 4: return "Proximamente"
        default: return nil
        }
    }
    
}

final class MovieAPI {
    static private let imgBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    static private var urlBase: String = "https://api.themoviedb.org/3"
    
    /**    func to help to get Data of apis
     - Parameter url: url of api
     
     */
    static func getApiData(from url: URLApi, handler: @escaping (Data) -> Void) {
        guard let url = URL(string: URLComponentsHelper.makeUrl(path: url)) else { return }
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else { return }
            handler(datos)
        }
        task.resume()
    }
    
    /**    func to help to get Data of apis with key
     - Parameter url: endpoint of URLApi
     - Parameter key: Word to search
     */
    static func getApiData(from url: URLApi, key query: String, handler: @escaping (Data) -> Void) {
        guard let url = URL(string: URLComponentsHelper.urlWithSearch(path: url, query: query)) else { return }
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else { return }
            handler(datos)
        }
        task.resume()
    }
    
    /**    func to help to get Data of apis with idMovies
     - Parameter url: endpoint of URLApi
     - Parameter id: id of movie
     */
    static func getApiData(from url: URLApi, id idMovie: Int, handler: @escaping (Data) -> Void) {
        guard let url = URL(string: URLComponentsHelper.urlWithId(path: url, idMovie: idMovie))
        else { return }
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else { return }
            handler(datos)
        }
        task.resume()
    }
}
