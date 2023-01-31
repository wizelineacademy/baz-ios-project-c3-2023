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

class NetworkingProviderService: NetworkingProviderProtocol {
    
    static var shared: NetworkingProviderService = {
            let instance = NetworkingProviderService()
            return instance
        }()
        
        private init() {}
    
    func sendRequest<T: Decodable>(requestType: RequestType, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: requestType.strUrl) else {
            completion(.failure(ServiceError.badRequest))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.method.getTypeResponse()

        if let arrHeaders = requestType.arrHeaders {
            for header in arrHeaders {
                request.setValue(header.value, forHTTPHeaderField: header.forHTTPHeaderField)
            }
        }

        request.httpBody = requestType.httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
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
        task.resume()
    }
  
}
