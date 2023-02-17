//
//  PageResult.swift
//  BAZProject
//
//  Created by hlechuga on 01/02/23.
//

import Foundation

struct PageMoviesResult : Codable {
    internal init(page: Int, results: [Movie], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
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
