//
//  Reviews.swift
//  BAZProject
//
//  Created by hlechuga on 17/02/23.
//

import Foundation

struct Review: Codable{
    
    let author: String
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
    let url: String
    
    enum CodingKeys : String, CodingKey{
        case author
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "update_at"
        case url
    }
}


struct Reviews: Codable {
    
    let id: Int
    let page: Int
    let results: [Review]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
