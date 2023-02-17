//
//  MovieEndPoints.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 30/01/23.
//

import Foundation


enum MovieServices {
    case getTrending
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case serachKeyword(searchText: String)
    case search(searchText: String, page: Int)
    case getReviews(id: Int)
    case getSimilars(id: Int)
    case getRecommendations(id: Int)
}
 
extension MovieServices {
    
    var path: String {
        switch self {
        case .getTrending:
            return "/3/trending/movie/day"
        case .getNowPlaying:
            return "/3/movie/now_playing"
        case .getPopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .serachKeyword:
            return "/3/search/keyword"
        case .search:
            return "/3/search/movie"
        case .getReviews(let id):
            return "/3/movie/\(id)/reviews"
        case .getSimilars(let id):
            return "/3/movie/\(id)/similar"
        case .getRecommendations(let id):
            return "/3/movie/\(id)/recommendations"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .serachKeyword(let searchText):
            return ["query": searchText]
        case .search(let searchText, let page):
            return ["query": searchText, "page": page]
        default:
            return [:]

        }
    }
}
