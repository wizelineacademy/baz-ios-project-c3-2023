//
//  MoviesAPI.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieServicesProtocol {
    var page: Int { get set }
    func fetchMovies(type: fetchMoviesTypes, nextPage: Bool, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void)
    func fetchReviews(id: Int, completionHandler: @escaping([Review], MovieServiceError?) -> Void)
    func fetchCastByMovie(id: Int, completionHandler: @escaping([Cast], MovieServiceError?) -> Void)
}

extension MovieServicesProtocol {
    mutating func resetPaginationFetch() {
        self.page = 1
    }
}

class MoviesAPI: MovieServicesProtocol {
    
    let urlBaseString = "https://api.themoviedb.org/3"
    let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let language = "en"
    let region = "MX"
    var page: Int = 1
    
    let sessionShared = URLSession.shared
    
    func fetchMovies(type: fetchMoviesTypes, nextPage: Bool = false, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void) {
        let request = URLRequest(url: getURL(endpoint: type.endpoint, nextPage: nextPage))
        
        sessionShared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler([], .fetchError)
                return
            }
            do {
                let movies = try JSONDecoder().decode(MovieFetchResponse.self, from: data).results
                completionHandler(movies, nil)
            } catch {
                completionHandler([], .decodeError)
            }
        }.resume()
    }
    
    func fetchReviews(id: Int, completionHandler: @escaping ([Review], MovieServiceError?) -> Void) {
        
        let request = URLRequest(url: getURL(endpoint: .movieReviews(id: id)))

        sessionShared.dataTask(with: request) { data, error, response in
            guard let data = data else {
                completionHandler([], .fetchError)
                return
            }
            do {
                let reviews = try JSONDecoder().decode(ReviewResponse.self, from: data).results
                completionHandler(reviews, nil)
            } catch {
                completionHandler([], .decodeError)
            }
        }.resume()
    }
    
    func fetchCastByMovie(id: Int, completionHandler: @escaping ([Cast], MovieServiceError?) -> Void) {
        let request = URLRequest(url: getURL(endpoint: .castByMovie(id: id)))
        
        sessionShared.dataTask(with: request) { data, error, response in
            guard let data = data else {
                completionHandler([], .fetchError)
                return
            }
            
            do {
                let casts = try JSONDecoder().decode(CastResponse.self, from: data).cast
                guard let casts = casts else {
                    completionHandler([], .emptyData)
                    return
                }
                completionHandler(casts, nil)
            } catch {
                completionHandler([], .decodeError)
            }
        }.resume()
    }

    
    func getURL(endpoint: Endpoint, nextPage: Bool = false) -> URL {
        page = nextPage ? (page + 1) : page
        
        return URL(string: "\(urlBaseString)\(endpoint.url)?api_key=\(apiKey)\(endpoint.queryString)&language=\(language)&region=\(region)&page=\(page)")!
    }
}

/// fetchMoviesTypes defines the type to fetch movies based on their type
enum fetchMoviesTypes: Equatable {
    case trending, nowPlaying, popular, topRated, upComing, byKeyword(String), bySearch(String), bySimilarMovie(id: Int), byRecommendationMovie(id: Int), watched
    
    var endpoint: Endpoint {
        switch self {
        case .trending:
            return Endpoint.trending
        case .nowPlaying:
            return Endpoint.nowPlaying
        case .popular:
            return Endpoint.popular
        case .topRated:
            return Endpoint.topRated
        case .upComing:
            return Endpoint.upComing
        case .byKeyword(let string):
            return Endpoint.byKeyword(string)
        case .bySearch(let string):
            return Endpoint.bySearch(string)
        case .bySimilarMovie(let id):
            return Endpoint.bySimilarMovie(id: id)
        case .byRecommendationMovie(let id):
            return Endpoint.byRecommendationMovie(id: id)
        case .watched:
            return Endpoint.watched
        }
    }
    
    var title: String {
        switch self {
        case .trending:
            return "Trending Movies"
        case .nowPlaying:
            return "Now Playing Movies"
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        case .upComing:
            return "Up Coming Movies"
        case .byKeyword(let string):
            return "Search by \(string)"
        case .bySearch(let string):
            return "Search by \(string)"
        case .bySimilarMovie(_):
            return "Similar Movies"
        case .byRecommendationMovie(_):
            return "Recommendation Movies"
        case .watched:
            return "Movies Watched"
        }
    }
}

enum MovieServiceError: Error {
    case fetchError
    case decodeError
    case emptyData
    
    var description: String {
        switch self {
        case .fetchError:
            return "Error al obtener respuesta de Peliculas"
        case .decodeError:
            return "Error al decodificar respuesta"
        case .emptyData:
            return "No se encontraron datos"
        }
    }
}
