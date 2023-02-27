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
    
    private let hostName: String

    public init(hostName: String) {
        self.hostName = hostName
    }
    
    public func makeUrlRequest() -> URLRequest {
        let url = URL(string: "\(hostName)/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX")!
        let request = URLRequest(url: url)
        return request
    }
}
