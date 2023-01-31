//
//  NetworkingProvider+Protocol.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

protocol NetworkingProviderProtocol: AnyObject {
    func sendRequest<T: Decodable>(requestType: RequestType,
                     completion: @escaping (Result<T,Error>) -> Void)
}
