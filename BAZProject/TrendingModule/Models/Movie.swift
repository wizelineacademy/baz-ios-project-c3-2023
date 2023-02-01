//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let poster_path: String
    let adult : Bool
    let backdrop_path: String
    let original_language: String
    let original_title: String
    let overview: String
    let media_type: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    var dictionary: [String: Any] {
            return ["title": title,
                    "original_language": original_language,
                    "original_title": original_title,
                    "overview": overview,
                    "media_type": media_type,
                    "release_date": release_date]
        }
    var nsDictionary: NSDictionary {
            return dictionary as NSDictionary
        }
    
}

enum RateValue: String {
    case bad = "⭐️"
    case low = "⭐️⭐️"
    case medium = "⭐️⭐️⭐️"
    case higth = "⭐️⭐️⭐️⭐️"
    case better = "⭐️⭐️⭐️⭐️⭐️"
    
}

struct RateViewModel{
    let movieRate: Double
    
//    let movieEmojiRate
    var movieEmojiRate: RateValue{
        switch movieRate {
        case 0..<2:
            return .bad
        case 2..<4:
            return .low
        case 4..<6:
            return .medium
        case 6..<8:
            return .higth
        case 8...10:
            return .better
        default:
            return .low
        }
    }
}
