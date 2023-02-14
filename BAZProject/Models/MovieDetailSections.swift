//
//  MovieDetailSections.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import Foundation

enum MovieDetailSections: Int {
    case cast = 1
    case similar = 2
    case recommendation = 3
    
    var title: String {
        switch self{
        case .cast:
            return "Elenco"
        case .similar:
            return "Peliculas similares"
        case .recommendation:
            return "Peliculas recomendadas"
        }
    }
}
