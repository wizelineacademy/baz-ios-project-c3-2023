//
//  MoviesEndpoints.swift
//  BAZProject
//
//  Created by 1034209 on 02/02/23.
//

import Foundation

/// Endpoint defines the URL endpoint that is used to consume services from https://api.themoviedb.org/3
/// 
enum Endpoint {
    case trending, nowPlaying, popular, topRated, upComing, byKeyword(String), bySearch(String), bySimilarMovie(id: Int), byRecommendationMovie(id: Int), movieReviews(id: Int), castByMovie(id: Int)
    
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
        case .byKeyword(_):
            return "/search/keyword"
        case .bySearch(_):
            return "/search/movie"
        case .bySimilarMovie(let id):
            return "/movie/\(id)/similar"
        case .byRecommendationMovie(let id):
            return "/movie/\(id)/recommendations"
        case .movieReviews(let id):
            return "/movie/\(id)/reviews"
        case .castByMovie(let id):
            return "/movie/\(id)/credits"
        }
    }
    
    var queryString: String {
        switch self {
        case .byKeyword(let string):
            return "&query=\(string)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        case .bySearch(let string):
            return "&query=\(string)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        default:
            return ""
        }
    }
}
