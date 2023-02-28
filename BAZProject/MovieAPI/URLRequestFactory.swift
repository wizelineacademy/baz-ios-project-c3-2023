//
//  URLRequestFactory.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 27/02/23.
//

import Foundation

public protocol URLRequestFactory {
    func makeUrlRequest() -> URLRequest
}

class MovieCategoryURLRequestFactory: URLRequestFactory {
    
    private var category: MovieAPICategory

    public init(category: MovieAPICategory) {
        self.category = category
    }
    
    public func makeUrlRequest() -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/\(category.endpointUrl)?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX")!
        let request = URLRequest(url: url)
        return request
    }
}
