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
    
    struct MovieAPIError: Error { }
    
    init() { }
    
    /// Returns a decodable object.
    ///
    ///  - Parameter data: Data to decode.
    ///  - Returns: T: Decodable Object
    ///
    
    func mapToResult<T>(with data: Data) -> (T?, Error?) where T : Decodable {
        guard let movieResult = try? JSONDecoder().decode(T.self, from: data) else {
            return (nil, MovieAPIError())
        }
        return (movieResult, nil)
    }
}
