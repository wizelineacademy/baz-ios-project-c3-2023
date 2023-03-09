//
//  MovieAPI.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

struct MovieAPI {
    
    private init() {}
    
    /**
     Regresa la URL base de The MovieDB API
     
     La URL contiene como atributos predefinidos el api_key, page y language, sin embargo con query items se pueden incluir mas atributos
     
     - Parameters:
        - page: un entero que indica el número de pagina
        - queryItems: un diccionario donde cada elemento se transforma en un objeto URLQueryItem y es usado como atributo de la URL retornada
     - Returns: regresa un objeto de tipo URL
     */
    static func getBaseURL(for page: Int = 1, queryItems: [String: String] = [:]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3"
        var items: [URLQueryItem] = queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) })
        let defaultItems = [
            URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: "es")
        ]
        items.append(contentsOf: defaultItems)
        urlComponents.queryItems = items
        return urlComponents.url
    }
    /**
     Regresa la URL base de las imagenes provistas por The MovieDB API
     */
    static var imageBaseURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p"
        return components.url
    }
}
