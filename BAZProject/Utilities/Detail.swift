//
//  Detail.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

enum Detail: String, CaseIterable {
    case credits
    case reviews
    case recommendations
    case similar
    
    /** Returns the view controller title */
    var title: String {
        switch self {
        case .credits:
            return "Reparto"
        case .reviews:
            return "Reseñas"
        case .recommendations:
            return "Recomendaciones"
        case .similar:
            return "Similares"
        }
    }
    
    /** Returns the detail order */
    var order: Int {
        switch self {
        case .credits:
            return 0
        case .reviews:
            return 3
        case .recommendations:
            return 1
        case .similar:
            return 2
        }
    }
    
    /// Creates a request with the given id and the base URL
    /// - Parameter id: a integer that represents the movie id
    /// - Returns: a URLRequest created by the created URL
    func endPoint(for id: Int) -> URLRequest? {
        guard let baseURL = MovieAPI.getBaseURL() else { return nil }
        let url = baseURL.appendingPathComponent("/movie/\(id)/\(self)")
        return URLRequest(url: url)
    }
}
