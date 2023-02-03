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

extension RequestType {
    func getRequest() -> URLRequest {
        var request: URLRequest
        let url: URL = URL(string: self.strUrl)!
    
        request = URLRequest(url: url)
        request.httpMethod = self.method.getTypeResponse()

        if let arrHeaders = self.arrHeaders {
            for header in arrHeaders {
                request.setValue(header.value, forHTTPHeaderField: header.forHTTPHeaderField)
            }
        }
        return request
    }
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
