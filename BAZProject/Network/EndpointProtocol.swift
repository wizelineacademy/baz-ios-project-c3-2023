//
//  EndpointProtocol.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 17/02/23.
//

import Foundation
/**
   `Endpoint`is a protocol that  contains all the posible vaalues to fetch a URL API
    - Parameters:
     - base : the pincipal urls `String`
     - path :  the path afteURL`String` the pinc
     - urlComponens :  if exist a type of query
     - request :  the main request
 */
protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var urlComponents: URLComponents { get }
    var request: URLRequest { get }
}
