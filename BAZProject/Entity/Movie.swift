//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct ReponseMovies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let overView: String?
    let voteCount: Int?
    let adult: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overView = "overview"
        case voteCount  = "vote_count"
        case adult
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overView = try container.decodeIfPresent(String.self, forKey: .overView)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
    }
    
    init(id: Int? = nil, title: String? = nil, posterPath: String? = nil, overView: String? = nil, voteCount: Int? = nil, adult: Bool? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overView = overView
        self.voteCount = voteCount
        self.adult = adult
    }
}

struct MovieDetail: Codable {
    
}

enum TypeMovie: String {
    case popularity     = "popular"
    case nowPlaying    = "now_playing"
    case latest    = "latest"
    
    func getOptionMovie() -> String{
        return self.rawValue
    }
}

enum MethodType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
