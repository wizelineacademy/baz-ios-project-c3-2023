//
//  URLRequestFactory.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 27/02/23.
//

import Foundation

public protocol URLRequestFactory {
    func makeUrlRequest() -> URLRequest?
}

class MovieCategoryURLRequestFactory: URLRequestFactory {
    
    private var category: MovieAPICategory
    private let baseEndpoint = "https://api.themoviedb.org/3/"
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let language = "es"
    private let region = "MX"

    public init(category: MovieAPICategory) {
        self.category = category
    }
    
    /// Returns the endpoint of the category given in Mexico region and in spanish laguague.
    ///
    ///  - Parameter category: The category to be consulted
    ///  - Returns: URLRequest
    ///
    
    public func makeUrlRequest() -> URLRequest? {
        let url = URL(string: "\(baseEndpoint)\(category.endpointUrl)?api_key=\(apiKey)&language=\(language)&region=\(region)")
        guard let url = url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
