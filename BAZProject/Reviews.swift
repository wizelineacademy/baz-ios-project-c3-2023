//
//  Reviews.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 14/02/23.
//

import Foundation

struct Reviews: Codable {
    let id, page: Int
    let results: [ResultReviews]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ResultReviews: Codable {
    let author: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case author
        case content
    }
}
