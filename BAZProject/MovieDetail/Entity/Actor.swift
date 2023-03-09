//
//  Actor.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

struct Actor: Decodable, GenericCollectionViewRow {
    
    let id: Int
    let name: String
    let originalName: String
    var profilePath: String?
    let roll: String
    let castId: Int
    let character: String
    let order: Int
    var collectionCellClass: any GenericCollectionViewCell.Type = ActorCollectionViewCell.self
    
    /**
     Regresa la url de la imagen correspondiente al perfil del actor
     - Parameters:
        - size: es el tamaño de la imagen su valor por default es 200, los tamaños soportados son 200, 300, 400 y 500 siendo 200 el tamaño más pequeño
     - Returns: regresa la URL construida a partir de la URL base
     */
    func getImageURL(size: ImageSize = .small) -> URL? {
        guard let imageURL = profilePath else { return nil }
        return MovieAPI.imageBaseURL?.appendingPathComponent("/w\(size.rawValue)\(imageURL)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case roll = "known_for_department"
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case order
    }
}

struct Actors: Decodable, GenericTableViewRow {
    
    let actors: [Actor]
    var detail: Detail?
    
    var tableCellClass: any GenericTableViewCell.Type = SliderTableViewCell.self
    var id: Int {
        detail?.order ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
