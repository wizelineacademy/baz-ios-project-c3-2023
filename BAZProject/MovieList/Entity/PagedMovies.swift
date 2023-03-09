//
//  PagedMovies.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

struct PagedMovies: Decodable, GenericTableViewRow {
    
    let movies: [Movie]
    let totalPages: Int
    let page: Int
    var detail: Detail?
    var tableCellClass: any GenericTableViewCell.Type = SliderTableViewCell.self
    
    var id: Int {
        detail?.order ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
        case page
    }
}
