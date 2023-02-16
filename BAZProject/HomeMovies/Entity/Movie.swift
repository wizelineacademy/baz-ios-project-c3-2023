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
    let id: Int?
    let title: String?
    let original_title: String?
    let poster_path: String?
    let media_type: String?
    
    init(id: Int? = 0, title: String? = "", original_title: String? = "", poster_path: String? = "", media_type: String? = "") {
        self.id = id
        self.title = title
        self.original_title = original_title
        self.poster_path = poster_path
        self.media_type = media_type
    }
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
    
    var typeName: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

enum CellPath {
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"

    case imageUrl(urlString: String)
}

extension CellPath {
    
    var completeImageURL: String{
        switch self {
        case .imageUrl(urlString: let string):
            return CellPath.baseImageURL+string
        }
    }
}
