//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let isAdult: Bool
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let mediaType: String?
    let genderIds: [Int]
    let popularity: Double
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private let posterPath: String
    private let backgroundImagePath: String?
    private let publishedDate: String
    
    var releaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: publishedDate)
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date ?? Date())
    }
    
    func getPosterURL(with zise: Int = 200) -> URL? {
        self.baseURL?.appendingPathComponent("/w\(zise)\(self.posterPath)")
    }
    
    func getBackgroundMovieURL(with zise: Int = 200) -> URL? {
        guard let backgroundPath = self.backgroundImagePath else {
            return nil
        }
        return self.baseURL?.appendingPathComponent("/w\(zise)\(backgroundPath)")
    }
    
    private var baseURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p"
        return components.url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case isAdult = "adult"
        case backgroundImagePath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case mediaType = "media_type"
        case genderIds = "genre_ids"
        case popularity = "popularity"
        case publishedDate = "release_date"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
