//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: MovieResult
struct MovieResult: Codable {
    let results: [Movie]
}

// MARK: Movie
struct Movie: Codable {
    let id: Int?
    let title: String?
    let originalTitle: String?
    let posterPath: String?
    let mediaType: String?
    
    init(id: Int? = 0, title: String? = "", original_title: String? = "", poster_path: String? = "", media_type: String? = "") {
        self.id = id
        self.title = title
        self.originalTitle = original_title
        self.posterPath = poster_path
        self.mediaType = media_type
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case mediaType = "media_type"
    }
}

// MARK: MovieCategory
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
