//
//  WSError.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 01/02/23.
//

import Foundation

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
