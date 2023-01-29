//
//  NetworkingProviderService.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

class NetworkingProviderService: NetworkingProviderProtocol {
    
    static var shared: NetworkingProviderService = {
            let instance = NetworkingProviderService()
            return instance
        }()
        
        private init() {}
    
    func sendRequest(requestType: RequestType, completion: @escaping (Bool, Data?) -> Void) {
        guard let url = URL(string: requestType.strUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.method.getTypeResponse()

        if let arrHeaders = requestType.arrHeaders {
            for header in arrHeaders {
                request.setValue(header.value, forHTTPHeaderField: header.forHTTPHeaderField)
            }
        }

        request.httpBody = requestType.httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("Error: Did not receive data")
                    completion(false, nil)
                    return
                }
                completion(true, data)
            }
        }
        task.resume()
    }
}
