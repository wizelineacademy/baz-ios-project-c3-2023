//
//  MovieResult.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 07/02/23.
//

import Foundation

struct MovieResult: Decodable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
