//
//  UrlComponentsHelper.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 23/02/23.
//

import Foundation

fincal class URLComponentsHelper {
    
    /**    func to make Url
     - Parameter path: endpoint of URLApi
    - Returns: URL
     */
    static func makeUrl(path: URLApi) -> String {
        var url = makeUrl()
        url.path = path.getEndpointUrl
        return url.string ?? ""
    }
    
    /**    func to make Url for search
     - Parameter path: endpoint of URLApi
     - Parameter query: Query to search
    - Returns: URL
     */
    static func urlWithSearch(path: URLApi, query: String) -> String {
        var url = makeUrl()
        url.path = path.getEndpointUrl
        let queryItemQuery = URLQueryItem(name: "query", value: query)
        url.queryItems?.append(queryItemQuery)
        return url.string ?? ""
    }
    
    /**    func to make Url with movie Id
     - Parameter path: endpoint of URLApi
     - Parameter idMovie: Id for search movie
    - Returns: URL
     */
    static func urlWithId(path: URLApi, idMovie: Int) -> String {
        var url = makeUrl()
        url.path = "/3/movie/\(idMovie)" + path.getEndpointUrl
        return url.string ?? ""
    }
    
    static func makeUrl() -> URLComponents {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.themoviedb.org"
        let queryItemApiKey = URLQueryItem(name: "api_key", value: KeychainHelper.shared.getApiKey()?.refreshToken)
        let queryItemLanguage = URLQueryItem(name: "language", value: "es")
        let queryItemPague = URLQueryItem(name: "page", value: "1")
        url.queryItems = [queryItemApiKey, queryItemLanguage, queryItemPague]
        return url
    }
    
    /**    func to make image URLs
     - Parameter imageUrl: endpoint of imageUrl
    - Returns: image URL
     */
    static func imageUrl(imageUrl: String) -> String {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "image.tmdb.org"
        url.path = "/t/p/w500" + imageUrl
        return url.string ?? ""
    }
}
