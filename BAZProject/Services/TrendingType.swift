//
//  TrendingType.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

enum MediaType: String, Codable {
    case all, movie, tv, person
    
    func getMediaTypeTitle() -> String {
        switch self {
        case .all:
            return "Todos"
        case .movie:
            return "Peliculas"
        case .tv:
            return "Televisión"
        case .person:
            return "Personas"
        }
    }
}

enum TimeWindowType: String {
    case day, week
}
