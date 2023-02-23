//
//  Strings.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//

enum RequestType: String {
    case trending = "trending/movie/day?"
    case topRated = "movie/top_rated?"
    case nowPlaying = "movie/now_playing?"
    case popular = "movie/popular?"
    case search = "search/movie?"
}

enum myUrls: String {
    case basePath = "https://api.themoviedb.org/3/"
    case imagePath = "https://image.tmdb.org/t/p/w500"
}

enum storyboards: String {
    case details = "MovieDetails"
}

enum viewControllers: String {
    case details = "MovieDetailsViewController"
}
