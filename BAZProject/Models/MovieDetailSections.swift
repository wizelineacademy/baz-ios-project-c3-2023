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
        switch self {
        case .cast:
            return NSLocalizedString("MDS.cast", comment: "section title")
        case .similar:
            return NSLocalizedString("MDS.similarMovies", comment: "section title")
        case .recommendation:
            return NSLocalizedString("MDS.recomendationMovies", comment: "section title")
        }
    }
}
