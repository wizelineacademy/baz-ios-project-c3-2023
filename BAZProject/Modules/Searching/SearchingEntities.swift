//
//  SearchingEntities.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

struct SearchResult: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}
