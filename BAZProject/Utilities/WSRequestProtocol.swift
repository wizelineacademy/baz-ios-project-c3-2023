//
//  WSRequestProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

protocol WSRequestProtocol: AnyObject {
    func fetch<Response: Decodable>(request: URLRequest?, completion: @escaping (Result<Response, Error>) -> Void)
    func decodeJson<Response: Decodable>(from data: Data, decoder: JSONDecoder, completion: (Result<Response, Error>) -> Void)
}

extension WSRequestProtocol {
    
    /**
     Crea una tarea de manera sincrona, que regresa contenido de la URL contenida en un objeto URLRequest
     - Parameters:
        - request: un objeto URLRequest que contiene una URL base, body, etc.
        - completion: un closure que se llama cuando la tarea ha sido completada
     - Returns: regresa un enum de tipo Result donde, en caso de ser exitoso, regresa los datos esperados en el valor asociado del success, en caso contrario regresa un error como valor asociado al caso failure
     
     ````
     guard let url = movie.getPosterURL(with: 300) else { return }
     
     sendRequest(request: URLRequest(url: url)) { result in
         switch result {
         case .success(let data):
            ... your code on success
         case .failure(let error):
            ... your code on error
         }
     }
     ````
     */
    func fetch<Response: Decodable>(request: URLRequest?, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let request = request else {
            return completion(.failure(WSError.invalidRequest))
        }

        DispatchQueue.global(qos: .utility).async {
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        return completion(.failure(error))
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse,
                       let data = data {
                        switch httpResponse.statusCode {
                        case 200...299:
                            self?.decodeJson(from: data, completion: completion)
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
    
    /**
     Intenta decodificar el objeto recibido con un decoder tipo JSONDecoder con el tipo de Objeto recibido o inferido
     - Parameters:
        - data: un objeto tipo Data
        - decoder: un objeto tipo JSONDecoder
     - Returns: regresa un objeto del tipo Result, donde el caso de exito regresa el dato esperado y en caso contrario regresa un error
     ````
     self.decodeJson(from: data, completion: (Result<MovieList, Error>) -> Void)
     ````
     */
    func decodeJson<Response: Decodable>(from data: Data, decoder: JSONDecoder = JSONDecoder(), completion: (Result<Response, Error>) -> Void) {
        do {
            let response = try decoder.decode(Response.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
}
