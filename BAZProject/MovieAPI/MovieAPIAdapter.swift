//
//  MovieAPIAdapter.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 23/02/23.
//

import Foundation

public protocol DecodableResultAdapter {
    func mapToResult<T: Decodable>(with data: Data) -> (T?, Error?)
}

class JSONDecoderResultAdapter: DecodableResultAdapter {
    
    private let decoder: JSONDecoder
    struct MovieAPIError: Error { }
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func mapToResult<T>(with data: Data) -> (T?, Error?) where T : Decodable {
        guard let movieResult = try? decoder.decode(T.self, from: data) else{
            return (nil, MovieAPIError())
        }
        return (movieResult, nil)
    }
    
}

protocol URLRequestFactory {
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

class URLSessionFetcher {
    
    private let urlRequestFactory: URLRequestFactory
    private let decodableResultAdapter: DecodableResultAdapter
    private struct DataNotFoundError: Error { }

    init(urlRequestFactory: URLRequestFactory, decodableResultAdapter: DecodableResultAdapter) {
        self.urlRequestFactory = urlRequestFactory
        self.decodableResultAdapter = decodableResultAdapter
    }
    
    func fetchData<T: Decodable>(completionHandler: @escaping (T?, Error?) -> Void) {
        let urlRequest = urlRequestFactory.makeUrlRequest()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in  //[weak self]
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let data = data
                else {
                    completionHandler(nil, DataNotFoundError()); return
                }
                let movieResult: (T?, Error?) = self.decodableResultAdapter.mapToResult(with: data)
                completionHandler(movieResult.0, movieResult.1)
            }
        }
        task.resume()
    }
    
}
