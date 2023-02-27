//
//  URLSessionFetcher.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 27/02/23.
//

import Foundation

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
