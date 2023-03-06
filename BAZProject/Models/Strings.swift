//
//  Strings.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//

enum RequestType: String {
    case trending = "trending/movie/day"
    case topRated = "movie/top_rated"
    case popular = "movie/popular"
    case upcoming = "movie/upcoming"
    case nowPlaying = "movie/now_playing"
    case search = "search/movie"
    case similar = "/similar"
    case recommended = "/recommendations"
    case casting = "/credits"

}

enum myUrls: String {
    case basePath = "https://api.themoviedb.org/3/"
    case imagePath = "https://image.tmdb.org/t/p/w500"
    case moviePath = "https://api.themoviedb.org/3/movie/"
}

enum storyboards: String {
    case details = "MovieDetails"
}

enum viewControllers: String {
    case details = "MovieDetailsViewController"
}

enum genres: Int {
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mystery = 9648
    case Romance = 10749
    case Science_Fiction = 878
    case TV_Movie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37
    case Desconocido
}
