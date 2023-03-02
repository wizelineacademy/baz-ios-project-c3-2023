//
//  MSEntity.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

struct MSEntity {
    let viewTitle: String
    let itemsForRow: Int
}

enum MSError: Error {
    case emptyText
    case invalidURL
    case invalidPage
}

extension MSError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyText: return "Escribe una palabra en el campo de busqueda."
        case .invalidURL: return "URL invalida"
        case .invalidPage: return "La Pagina no existe"
        }
    }
}
