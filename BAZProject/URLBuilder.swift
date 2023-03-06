//
//  URLBuilder.swift
//  BAZProject
//
//  Created by 1050210 on 21/02/23.
//

import Foundation

class URLBuilder {
    
    /// Get the url base of the enum URLType, construct the url and return it
    ///
    /// - Parameter urlType: enum based of the type of consumption
    /// - Parameter searchTerm: Optional parameter for the keyword and search urls
    /// - Returns: the build url base on the enum URLType given to the function
    static func getUrl(urlType: URLType, searchTerm: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3\(urlType.urlPath)"
        let itemApiKey = URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        components.queryItems = [itemApiKey]
        if let searchTerm = searchTerm{
            let itemQuery = URLQueryItem(name: "query", value: searchTerm)
            components.queryItems = [itemApiKey, itemQuery]
        }
        return components.url
    }
}

enum URLType {
    case trending, nowPlaying, popular, topRated, upcoming, details(Int), reviews(Int), cast(Int), similar(Int), recommendation(Int), keyword, search
    
    var urlPath: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        case .details(let idMovie):
            return "/movie/\(idMovie)"
        case .reviews(let idMovie):
            return "/movie/\(idMovie)/reviews"
        case .cast(let idMovie):
            return "/movie/\(idMovie)/credits"
        case .similar(let idMovie):
            return "/movie/\(idMovie)/similar"
        case .recommendation(let idMovie):
            return "/movie/\(idMovie)/recommendations"
        case .keyword:
            return "/search/keyword"
        case .search:
            return "/search/movie"
        }
    }
}
