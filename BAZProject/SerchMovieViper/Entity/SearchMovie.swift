//
//  SearchMovie.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//

import Foundation

struct SearchMovie: Codable {
    let id: Int
    let original_title: String?
    let backdrop_path: String?
}

struct Keyword: Codable {
    let name: String?
}
