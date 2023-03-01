//
//  SegmentedMovies.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 28/02/23.
//

import Foundation

enum SegmentedMovies: Int, CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upComing
    
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComing:
            return "Upcoming"
        }
    }
}
