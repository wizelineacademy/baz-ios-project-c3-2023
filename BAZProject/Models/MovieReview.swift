//
//  MovieReview.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 07/02/23.
//

import Foundation

struct MovieReview: Decodable {
    let author: String
    let content: String
    let authorDetail: MovieReviewAuthor
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
        case authorDetail = "author_details"
        case createdAt = "created_at"
    }
}
