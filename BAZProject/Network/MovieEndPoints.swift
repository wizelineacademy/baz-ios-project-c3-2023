//
//  MovieEndPoints.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 30/01/23.
//

import Foundation

/**
   `MovieServices`is an enum that  contains all the posible endpoints in the MovieDB API
 */
enum MovieServices {
    case getTrending
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case serachKeyword(searchText: String)
    case search(searchText: String, page: Int)
    case getReviews(id: Int)
    case getSimilars(id: Int)
    case getRecommendations(id: Int)
}

extension MovieServices: Endpoint {
    private var apiKey: URLQueryItem {
        return URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    }
    
    var base: String {
        return "https://api.themoviedb.org"
    }

    var path: String {
        switch self {
        case .getTrending:
            return "/3/trending/movie/day"
        case .getNowPlaying:
            return "/3/movie/now_playing"
        case .getPopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .serachKeyword:
            return "/3/search/keyword"
        case .search:
            return "/3/search/movie"
        case .getReviews(let id):
            return "/3/movie/\(id)/reviews"
        case .getSimilars(let id):
            return "/3/movie/\(id)/similar"
        case .getRecommendations(let id):
            return "/3/movie/\(id)/recommendations"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .serachKeyword(let searchText):
            return ["query": searchText]
        case .search(let searchText, let page):
            return ["query": searchText, "page": page]
        default:
            return [:]

        }
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        var queryItems = [URLQueryItem]()
        // The api key is added as base query item
        queryItems.append(apiKey)
        // If a endpoint need extra query items, these are defined below.
        switch self {
        case .search(let text, _):
            let queryItem = URLQueryItem(name: "query", value: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(queryItem)
        default: break
        }
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
