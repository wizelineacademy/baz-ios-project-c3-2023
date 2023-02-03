//
//  TrendingEntity.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
