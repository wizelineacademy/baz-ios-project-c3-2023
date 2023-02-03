//
//  GenericAPIProtocolo.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 31/01/23.
//

import Foundation


protocol GenericAPI {
    var baseURL: String {get}
    var apiKey: String {get}
    func decodeJSON<T: Codable>(from data: Data, decoder: JSONDecoder) -> T?
    func fetch<T: Codable>(urlRequest: URLRequest, onCompletion: @escaping (Result<T, Error>) -> Void)
}

extension GenericAPI {
    /**
       This function fetch the data for the given  `url`
         
        - Parameters:
          - urlRequest: the url to fetch data
          - onComplation: its a block code that recibe Result and returns void `(Result<T, Error>) -> Void`
     */
    func fetch<T: Codable>(urlRequest: URLRequest, onCompletion: @escaping (Result<T, Error>) -> Void){
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, let result: T = self.decodeJSON(from: data) else {
                    return onCompletion(.failure(APIError.emptyData))
                }
                onCompletion(.success(result))
            }
        }
        task.resume()
    }
    
    /**
       This function decode data from data of type Data and returs  a generic  object `T`  that conforms the Codable protocols

        - Parameters:
          - from: the data from the url
          - decoder: you can send the type of decoder but default its JSONDecoder
     
        - Returns: a object tha conforms Codable Protocol `T?`.
     */
    func decodeJSON<T: Codable>(from data: Data, decoder: JSONDecoder = JSONDecoder()) -> T?{
        do {
            let entity = try decoder.decode(T.self, from: data)
            return entity
        } catch {
            return nil
        }
    }
}
