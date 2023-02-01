//
//  NetworkingProviderService.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

enum ServiceError: Error {
    case noData
    case response
    case parsingData
    case internalServer
    case badRequest
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol NetworkingProviderProtocol {
    var session: URLSessionProtocol { get }
    func sendRequest<T: Decodable>(_ request: URLRequest, callback: @escaping (Result<T,Error>) -> Void)
}

class NetworkingProviderService: NetworkingProviderProtocol {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func sendRequest<T: Decodable>(_ request: URLRequest, callback: @escaping (Result<T, Error>) -> Void) {
        let task = session.performDataTask(with: request) { (data, response, error) in
            self.handleRequest(data: data, response: response, error: error, completion: callback)
        }
        task.resume()
    }
    
    
    private func handleRequest<T:Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: (Result<T, Error>) -> Void) {
        
        if let error: Error = error {
            completion(.failure(error))
            return
        }
        
        guard let data: Data = data else {
            completion(.failure(ServiceError.noData))
            return
        }
        
        guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
            completion(.failure(ServiceError.response))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
            
        } catch {
            completion(.failure(ServiceError.parsingData))
        }
    }
}
