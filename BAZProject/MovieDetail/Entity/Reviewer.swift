//
//  Reviewer.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

struct Reviewer: Decodable {
    
    let name: String
    let userName: String
    let avatarPath: String?
    
    /**
     Regresa la url de la imagen correspondiente al avatar del autor
     - Parameters:
        - size: es el tamaño de la imagen su valor por default es 200, los tamaños soportados son 200, 300, 400 y 500 siendo 200 el tamaño más pequeño
     - Returns: regresa la URL construida a partir de la URL base
     */
    func getImageURL(size: ImageSize = .small) -> URL? {
        guard let imageURL = avatarPath else { return nil }
        return MovieAPI.imageBaseURL?.appendingPathComponent("/w\(size.rawValue)\(imageURL)")
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case userName = "username"
        case avatarPath = "avatar_path"
    }
}
