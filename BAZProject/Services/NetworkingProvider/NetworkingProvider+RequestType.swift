//
//  NetworkingProvider+RequestType.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

struct RequestType {
    var strUrl: String
    var method: MethodRequest
    var httpBody: Data?
    var arrHeaders: [HeaderCustom]?
}

enum MethodRequest {
    case GET, PUT, POST, DELETE
    
    func getTypeResponse() -> String {
        switch self {
        case .GET:
            return "GET"
        case .PUT:
            return "PUT"
        case .POST:
            return "POST"
        case .DELETE:
            return "DELETE"
        }
    }
}

struct HeaderCustom {
    var value: String
    var forHTTPHeaderField: String
}
