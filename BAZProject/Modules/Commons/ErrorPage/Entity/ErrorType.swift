//
//  ErrorType.swift
//  BAZProject
//
//  Created by 1058889 on 31/01/23.
//

import Foundation

struct ErrorType {
    let title: String
    let message: String
    
    init(serviceError: ServiceError) {
        switch serviceError {
        case .noData:
            title = "Error when loading data"
            message = "Try again in a few minutes"
        case .response:
            title = "Service is not responding"
            message = "Bad URL request"
        case .parsingData:
            title = "Some error occured"
            message = "Please contact your administrator or report your issues at:\nTel: 0118-999-881-999"
        case .internalServer:
            title = "Internal server error"
            message = "Please wait"
        case .badRequest:
            title = "Service is not responding"
            message = "Bad URL request"
        }
    }
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
