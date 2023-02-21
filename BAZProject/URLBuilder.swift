//
//  URLBuilder.swift
//  BAZProject
//
//  Created by 1050210 on 21/02/23.
//

import Foundation

public class URLBuilder {
    
    public static let shared = URLBuilder()
    public var idMovie : Int = 0
    public var searchTerm: String?
    
    func getUrl(urlType: URLType) -> URL? {
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
    case trending, nowPlaying, popular, topRated, upcoming, details, reviews, cast, similar, recommendation, keyword, search
    
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
        case .details:
            return "/movie/\(URLBuilder.shared.idMovie)"
        case .reviews:
            return "/movie/\(URLBuilder.shared.idMovie)/reviews"
        case .cast:
            return "/movie/\(URLBuilder.shared.idMovie)/credits"
        case .similar:
            return "/movie/\(URLBuilder.shared.idMovie)/similar"
        case .recommendation:
            return "/movie/\(URLBuilder.shared.idMovie)/recommendations"
        case .keyword:
            return "/search/keyword"
        case .search:
            return "/search/movie"
        }
    }
}
