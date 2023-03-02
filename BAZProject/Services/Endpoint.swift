//
//  Endpoint.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import Foundation

enum BaseUrl {
    case images(sizeImage: SizeImageType)
    case api
    case apiWithEndPoint(endPoint: String)

    var url: String {
        switch self {
        case .images(sizeImage: let size):
            return "\(String.theMovieDBBasePathImages)/\(size.rawValue)"
        case .api:
            return .theMovieDbBasePath
        case .apiWithEndPoint(endPoint: let url):
            return "\(String.theMovieDbBasePath)\(url)\(String.theMovieDbEndBaseUrl)"
        }
    }
}

enum Endpoint {

    case img(idImage: String, sizeImage: SizeImageType)
    case trending(mediaType: MediaType, timeWindow: TimeWindowType)
    case detail(idMovie: String)
    case topRated
    case reviews(idMovie: String)
    case searchMovie(byKeywork: String)
    case nowPlaying
    case similarMovie(idMovie: String)
    case poularMovies
    case upcoming
    case recomendations(idMovie: String)
}

extension Endpoint {
    var urlString: String {
        switch self {
        case .img(idImage: let id, sizeImage: let size):
            return "\(BaseUrl.images(sizeImage: size).url)/\(id)"
        case .trending(mediaType: let media, timeWindow: let time):
            let url: String = "\(String.apiKeyEndPointTrending)/\(media.rawValue)/\(time.rawValue)"
            return BaseUrl.apiWithEndPoint(endPoint: url).url
        case .detail(idMovie: let movie):
            return "\(BaseUrl.api.url)/movie/\(movie)\(String.theMovieDbEndBaseUrl)\(String.theMovieDbAppendImages)"
        case .topRated:
            return BaseUrl.apiWithEndPoint(endPoint: .apiKeyEndPointMovieTopRated).url
        case .reviews(idMovie: let movie):
            let reviewsUrlString: String = "\(String.apiKeyEndPointMovie)/\(movie)/reviews"
            return BaseUrl.apiWithEndPoint(endPoint: reviewsUrlString).url
        case .searchMovie(byKeywork: let keyWord):
            let searchMovieUrlString: String = "\(String.apiKeyEndPointMovieSearch)"
            return "\(BaseUrl.apiWithEndPoint(endPoint: searchMovieUrlString).url)&query=\(keyWord)"
        case .nowPlaying:
            return BaseUrl.apiWithEndPoint(endPoint: .apiKeyEndPointNowPlaying).url
        case .similarMovie(idMovie: let movie):
            let similarUrlString: String = "\(String.apiKeyEndPointMovie)/\(movie)/similar"
            return "\(BaseUrl.apiWithEndPoint(endPoint: similarUrlString).url)"
        case .poularMovies:
            return BaseUrl.apiWithEndPoint(endPoint: .apiKeyEndPointPopularMovies).url
        case .upcoming:
            return BaseUrl.apiWithEndPoint(endPoint: .apiKeyEndPointUpcomingMovies).url
        case .recomendations(idMovie: let idMovie):
            let recomendationsUrlString: String = "\(String.apiKeyEndPointMovie)/\(idMovie)/\(String.apiKeyEndPointRecomendations)"
            return "\(BaseUrl.apiWithEndPoint(endPoint: recomendationsUrlString).url)"
        }
    }
}
