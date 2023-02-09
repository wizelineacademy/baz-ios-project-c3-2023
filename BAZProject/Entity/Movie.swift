//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct ReponseMovies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let overView: String?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overView = "overview"
        case voteCount  = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overView = try container.decodeIfPresent(String.self, forKey: .overView)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
    
    func getUrlImg(posterPath: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)")
    }
}

/**
 Enum for get list type movies from API
 Example:
 api.themoviedb.org/3/movie/popular
 api.themoviedb.org/3/movie/now_playing
 */
enum TypeMovieList: String {
    case popularity = "popular"
    case nowPlaying = "now_playing"
    case latest = "latest"
    
    func getOptionMovie() -> String{
        return self.rawValue
    }
}
