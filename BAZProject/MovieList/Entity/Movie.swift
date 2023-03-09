//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable, GenericTableViewRow, GenericCollectionViewRow {
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
    
    var tableCellClass: any GenericTableViewCell.Type = MovieDetailTableViewCell.self
    var collectionCellClass: any GenericCollectionViewCell.Type = MovieCollectionViewCell.self
    
    private let posterPath: String?
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
        guard let posterPath = posterPath else { return nil }
        return MovieAPI.imageBaseURL?.appendingPathComponent("/w\(size.rawValue)\(posterPath)")
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
        return MovieAPI.imageBaseURL?.appendingPathComponent("/w\(size.rawValue)\(backgroundPath)")
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

extension Movie: Equatable, Hashable {
    /**
     Makes this object hashable by id
     - Parameters:
        - hasher: a Hasher object
     - Returns: the mixed hasher
     */
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    /**
     Makes this object equatable by the id
     - Parameters:
        - lhs: a left Movie object to compare
        - rhs: a right Movie object to compare
     - Returns: a boolean that indicates if both given objects are equals
     */
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}
