//
//  WSRequest.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

class WSRequest {
    func sendRequest(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = request else {
            return completion(.failure(WSError.invalidRequest))
        }

        DispatchQueue.global(qos: .utility).async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        return completion(.failure(error))
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse,
                       let data = data {
                        switch httpResponse.statusCode {
                        case 200...299:
                            return completion(.success(data)
                            )
                        default:
                            return completion(.failure(WSError.nullResponse))
                        }
                    } else {
                        return completion(.failure(WSError.nullResponse))
                    }
                }
            }
            task.resume()
        }
    }
    
    func decodeJson<Response: Decodable>(from data: Data, decoder: JSONDecoder = JSONDecoder()) throws -> Response {
        do {
            let response = try decoder.decode(Response.self, from: data)
            return response
        } catch let error {
            throw error
        }
    }
}
