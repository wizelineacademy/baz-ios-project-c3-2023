//
//  Review.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

struct Review: Decodable, GenericCollectionViewRow {
    
    let author: String
    let reviewer: Reviewer
    let content: String
    let created: String
    let updated: String
    let url: URL
    var collectionCellClass: any GenericCollectionViewCell.Type = ReviewCollectionViewCell.self
    
    enum CodingKeys: String, CodingKey {
        case author
        case reviewer = "author_details"
        case content
        case created = "created_at"
        case updated = "updated_at"
        case url
    }
}

struct Reviews: Decodable, GenericTableViewRow {
    
    let reviews: [Review]
    var detail: Detail?
    var tableCellClass: any GenericTableViewCell.Type = SliderTableViewCell.self
    
    var id: Int {
        detail?.order ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
}
