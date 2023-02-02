//
//  WSRequest.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

class WSRequest {
    
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
    
    /**
     Intenta decodificar el objeto recibido con un decoder tipo JSONDecoder con el tipo de Objeto recibido o inferido
     - Parameters:
        - data: un objeto tipo Data
        - decoder: un objeto tipo JSONDecoder
     - Returns: regresa un objeto del tipo especificado, en caso de error propaga el error correspondiente
     ````
     do {
         let response: MoviesList = try decodeJson(from: data)
     } catch let error {
         ... your code on error
     }
     ````
     */
    func decodeJson<Response: Decodable>(from data: Data, decoder: JSONDecoder = JSONDecoder()) throws -> Response {
        do {
            let response = try decoder.decode(Response.self, from: data)
            return response
        } catch let error {
            throw error
        }
    }
}
