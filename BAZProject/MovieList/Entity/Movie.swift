//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable, Hashable {
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
    var movieSeenCount: Int?
    
    private let posterPath: String
    private let backgroundImagePath: String?
    private let publishedDate: String
    
    var releaseDate: String? {
        publishedDate.convertDate(format: "yyyy-MM-dd", to: "dd MMMM yyyy")
    }
    
    var timesSeen: String? {
        if let movieSeenCount = movieSeenCount {
            let subfix = movieSeenCount == 1 ? "vez" : "veces"
            return "Vista \(movieSeenCount) \(subfix)"
        }
        return nil
    }
    
    /**
     Regresa la url de la imagen correspondiente al poster de la pelicula
     - Parameters:
        - size: es el tamaño de la imagen su valor por default es 200, los tamaños soportados son 200, 300, 400 y 500 siendo 200 el tamaño más pequeño
     - Returns: regresa la URL construida a partir de la URL base
     */
    func getPosterURL(size: ImageSize = .small) -> URL? {
        self.baseURL?.appendingPathComponent("/w\(size.rawValue)\(self.posterPath)")
    }
    
    /**
     Regresa la url de la imagen correspondiente al background de la imagen de la pelicula
     - Parameters:
        - size: es el tamaño de la imagen su valor por default es 200, los tamaños soportados son 200, 300, 400 y 500 siendo 200 el tamaño más pequeño
     - Returns: regresa la URL construida a partir de la URL base
     */
    func getBackgroundMovieURL(size: ImageSize = .small) -> URL? {
        guard let backgroundPath = self.backgroundImagePath else {
            return nil
        }
        return self.baseURL?.appendingPathComponent("/w\(size.rawValue)\(backgroundPath)")
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
        case movieSeenCount
    }
}
