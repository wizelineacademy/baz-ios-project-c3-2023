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
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let title: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
    init(adult: Bool? = true, backdrop_path: String? = "", id: Int? = 0, title: String? = "", original_language: String? = "", original_title: String? = "", overview: String? = "", poster_path: String? = "", media_type: String? = "", genre_ids: [Int]? = [], popularity: Double = 0, release_date: String? = "", video: Bool? = true, vote_average: Double? = 0, vote_count: Int? = 0) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.id = id
        self.title = title
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.poster_path = poster_path
        self.media_type = media_type
        self.genre_ids = genre_ids
        self.popularity = popularity
        self.release_date = release_date
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
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
