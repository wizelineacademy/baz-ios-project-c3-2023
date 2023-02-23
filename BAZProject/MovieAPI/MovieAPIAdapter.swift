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
    
    func mapToResult<T: Decodable>(with data: Data) -> (T?, Error?) {
        guard let movieResult = try? JSONDecoder().decode(T.self, from: data) else{
            return (nil, MovieAPIError())
        }
        return (movieResult, nil)
    }
    
}

class URLSessionFetcher {
    
    private let decodableResultAdapter: DecodableResultAdapter
    private struct DataNotFoundError: Error { }

    init(decodableResultAdapter: DecodableResultAdapter) {
        self.decodableResultAdapter = decodableResultAdapter
    }
    
    func fetchData<T: Decodable>(completionHandler: @escaping (T?, Error?) -> Void){
        if let url  = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }else{
                    guard let data = data,
                          let movieResult = try? JSONDecoder().decode(T.self, from: data)
                    else {
                        completionHandler(nil, DataNotFoundError()); return
                    }
                    completionHandler(movieResult, nil)
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
    
}
