//
//  PageResult.swift
//  BAZProject
//
//  Created by hlechuga on 01/02/23.
//

import Foundation

struct PageMoviesResult : Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page         = "page"
        case totalPages   = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
