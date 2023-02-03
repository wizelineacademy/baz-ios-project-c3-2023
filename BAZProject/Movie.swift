//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct MovieResult: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let media_type: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

enum MovieCategory: String {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var endpoint: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
}

class BazRequest: NSObject{
    
    static let baseURL = "http://"
    
    static func getURL(_ endpoint: MovieCategory) -> String?{
        let method = endpoint.rawValue
        
        if method.isEmpty{
            return nil
        }
        var requestUrl: String
        requestUrl = baseURL+method
        
        return requestUrl
    }
}
