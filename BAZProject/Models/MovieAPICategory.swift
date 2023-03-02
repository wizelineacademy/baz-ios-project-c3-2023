//
//  MovieAPICategory.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import Foundation

enum MovieAPICategory: Int {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var endpointUrl: String {
        switch self {
        case .trending:
            return "trending/movie/day"
        case .nowPlaying:
            return "movie/now_playing"
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        }
    }
    
    var categoryName: String {
        switch self {
        case .trending:
            return NSLocalizedString("CategoryName.trending", comment: "section title")
        case .nowPlaying:
            return NSLocalizedString("CategoryName.nowPlaying", comment: "section title")
        case .popular:
            return NSLocalizedString("CategoryName.popular", comment: "section title")
        case .topRated:
            return NSLocalizedString("CategoryName.topRated", comment: "section title")
        case .upcoming:
            return NSLocalizedString("CategoryName.upcoming", comment: "section title")
        }
    }
    
    static let allMovieAPICategories = [trending.categoryName,
                                        nowPlaying.categoryName,
                                        popular.categoryName,
                                        topRated.categoryName,
                                        upcoming.categoryName]
}
