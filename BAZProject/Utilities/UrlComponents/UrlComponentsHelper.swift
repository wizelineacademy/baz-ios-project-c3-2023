//
//  UrlComponentsHelper.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 23/02/23.
//

import Foundation

class URLComponentsHelper {
    static func makeUrl(path: URLApi) -> String {
        var url = makeUrl()
        url.path = path.getEndpointUrl
        return url.string ?? ""
    }
    
    static func urlWithSearch(path: URLApi, query: String) -> String {
        var url = makeUrl()
        url.path = path.getEndpointUrl
        let queryItemQuery = URLQueryItem(name: "query", value: query)
        url.queryItems?.append(queryItemQuery)
        return url.string ?? ""
    }
    
    static func urlWithId(path: URLApi, idMovie: Int) -> String {
        var url = makeUrl()
        url.path = "/3/movie/\(idMovie)" + path.getEndpointUrl
        return url.string ?? ""
    }
    
    static func makeUrl() -> URLComponents {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.themoviedb.org"
        let queryItemApiKey = URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        let queryItemLanguage = URLQueryItem(name: "language", value: "es")
        let queryItemPague = URLQueryItem(name: "page", value: "1")
        url.queryItems = [queryItemApiKey, queryItemLanguage, queryItemPague]
        return url
    }
}
