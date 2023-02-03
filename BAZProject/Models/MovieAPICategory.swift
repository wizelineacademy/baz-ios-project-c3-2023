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
            return "Trending"
        case .nowPlaying:
            return "Now playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    static let allMovieAPICategories = [trending.categoryName,
                                        nowPlaying.categoryName,
                                        popular.categoryName,
                                        topRated.categoryName,
                                        upcoming.categoryName]
}
