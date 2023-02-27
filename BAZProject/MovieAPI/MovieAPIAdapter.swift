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
