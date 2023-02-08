//
//  Keyword.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import Foundation

// MARK: - Welcome
struct Keyword: Codable {
    let page: Int
    let results: [ResultKeyword]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultKeyword: Codable {
    let name: String
    let id: Int
}
