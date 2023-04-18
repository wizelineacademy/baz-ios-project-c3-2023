//
//  CVMovieCellViewEntity.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 16/04/23.
//

import Foundation
import UIKit

class CVMovieHubViewEntityMovieItem {
    let image: String
    let title: String
    let rating: Int
    let description: String
    init(image: String, title: String, rating: Int, description: String) {
        self.image = image
        self.title = title
        self.rating = rating
        self.description = description
    }
}

class CVMovieHubViewEntitySection {
    let sectionName: String
    let availableMovies: [CVMovieHubViewEntityMovieItem]
    
    init(sectionName: String, availableMovies: [CVMovieHubViewEntityMovieItem]) {
        self.sectionName = sectionName
        self.availableMovies = availableMovies
    }
}


class  CVMovieHubViewEntity : CVViewEntityBase {
    let configuration : [CVMovieHubViewEntitySection]
    init(configuration:[CVMovieHubViewEntitySection]) {
        self.configuration = configuration
    }
}
