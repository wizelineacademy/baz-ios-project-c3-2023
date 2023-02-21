//
//  MovieCell.swift
//  BAZProject
//
//  Created by 1014600 on 20/02/23.
//

import Foundation

// MARK: CellPath
enum CellPath {
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"

    case imageUrl(urlString: String)
}

extension CellPath {
    
    var completeImageURL: String{
        switch self {
        case .imageUrl(urlString: let string):
            return CellPath.baseImageURL+string
        }
    }
}
