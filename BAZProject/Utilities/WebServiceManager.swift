//
//  WebServiceManager.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

class WebServiceManager {
    private let manager: WSRequestProtocol
    
    init(request: WSRequestProtocol) {
        self.manager = request
    }

    func sendRequest<Response: Decodable>(completion: @escaping (Result<Response, Error>) -> Void) {
        guard let request = manager.request else {
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
                            return self.decodeJson(
                                from: data,
                                completion: completion
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
    
    private func decodeJson<Response: Decodable>(from data: Data, decoder: JSONDecoder = JSONDecoder(), completion: (Result<Response, Error>) -> Void) {
        do {
            let response = try decoder.decode(Response.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
}

enum WSError: Error {
    case invalidRequest
    case nullResponse
}

extension WSError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "No se pudo construir la petición"
        case .nullResponse:
            return "No se pudo construir la respuesta"
        }
    }
}
