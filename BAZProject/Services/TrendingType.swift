//
//  TrendingType.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

enum MediaType: String, Codable {
    case all, movie, television, person

    enum CodingKeys: String, CodingKey {
        case all, movie, person
        case television = "tv"
    }

    func getMediaTypeTitle() -> String {
        switch self {
        case .all:
            return "Todos"
        case .movie:
            return "Peliculas"
        case .television:
            return "Televisión"
        case .person:
            return "Personas"
        }
    }

    func getRawValue() -> Int {
        switch self {
        case .movie:
            return 0
        case .television:
            return 1
        case .person:
            return 2
        case .all:
            return 3
        }
    }
}

enum TimeWindowType: String {
    case day, week

    func getRawValue() -> Int {
        switch self {
        case .day:
            return 0
        case .week:
            return 1
        }
    }
}
