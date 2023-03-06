//
//  ServiceAPI.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol ServiceProtocol {
    var session: URLSessionProtocol { get }
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void)
}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

class ServiceAPI: ServiceProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    //MARK: function to consume gets
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void) {
        let request: URLRequest = URLRequest(url: endpoint)
        let task = session.performDataTask(with: request) { (data, response, error) in
            if let error: Error = error {
                callback(.failure(error))
                return
            }
            
            guard let data: Data = data else {
                callback(.failure(ServiceError.noData))
                return
            }
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                callback(.failure(ServiceError.response))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                callback(.failure(ServiceError.internalServer))
                return
            }
            
            
            do {
                let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decodedData))
            } catch {
                callback(.failure(ServiceError.parsingData))
            }
        }
        task.resume()
    }
}

enum ServiceError: Error {
    case noData
    case response
    case internalServer
    case parsingData
}

class MovieRequest: NSObject {
    static let baseURL: String = "https://api.themoviedb.org/3/"
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let lenguage: String = "es-MX"
    
    static func getURL(endpoint: Endpoint) -> URL? {
        let endpoint = endpoint.rawValue
        let requestURL: String = baseURL+endpoint+"?api_key=\(apiKey)&language=\(lenguage)"
        return URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    static func searchMovie(search query: String, allowAdultResults: Bool = false) -> URL? {
        let endpoint = Endpoint.searchMovies.rawValue+"?api_key=\(apiKey)&language=\(lenguage)"
        let requestURL: String = baseURL+endpoint+"&query=\(query)&include_adult=\(allowAdultResults)"
        return URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    static func getMovieDetail(of movieId: Int) -> URL? {
        let endpoint = Endpoint.movieDetail.rawValue+"/\(movieId)"
        let requestURL: String = baseURL+endpoint+"?api_key=\(apiKey)&language=\(lenguage)"
        return URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}

//MARK: Enum para las diferentes URIs
enum Endpoint: String {
    
    case trendingMovies = "trending/movie/day"
    case topRatedMovies = "movie/top_rated"
    case popularMovies = "movie/popular"
    case nowPlayingMovies = "movie/now_playing"
    case upcomingMovies = "movie/upcoming"
    case searchMovies = "search/movie"
    case movieDetail = "movie"
}

struct Response<T: Codable>: Codable {
    var page: Int?
    var results: T?
    var total_pages: Int?
    var total_results: Int?
}
