//
//  MoviesEndpoints.swift
//  BAZProject
//
//  Created by 1034209 on 02/02/23.
//

import Foundation

enum Endpoint {
    case trending, nowPlaying, popular, topRated, upComing, byKeyword(String), bySearch(String), bySimilarMovie(id: Int), byRecommendationMovie(id: Int), movieReviews(id: Int)
    
    var url: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upComing:
            return "/movie/upcoming"
        case .byKeyword(let string):
            return "/search/keyword?query=\(string)"
        case .bySearch(let string):
            return "/search/movie?query=\(string)"
        case .bySimilarMovie(let id):
            return "/movie/\(id)/similar"
        case .byRecommendationMovie(let id):
            return "/movie/\(id)/recommendations"
        case .movieReviews(let id):
            return "/movie/\(id)/reviews"
        }
    }
}
