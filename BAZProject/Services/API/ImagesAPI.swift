//
//  ImagesAPI.swift
//  BAZProject
//
//  Created by 1034209 on 08/02/23.
//

import Foundation

protocol ImagesServicesProtocol {
    func fetchImage(path: String, completionHandler: @escaping (Data?, ImagesServicesError?) -> Void)
}
class ImageApi: ImagesServicesProtocol {
    
    let urlBaseString = "https://image.tmdb.org/t/p/w500/"
    let sessionShared = URLSession.shared
    
    func fetchImage(path: String, completionHandler: @escaping (Data?, ImagesServicesError?) -> Void) {
        guard let url = URL(string: "\(urlBaseString)\(path)") else {
            completionHandler(nil, .notFoundImage)
            return
        }
        
        let request = URLRequest(url: url)
        
        sessionShared.dataTask(with: request) { data, error, response in
            guard let data = data else {
                completionHandler(nil, .fetchError)
                return
            }
            completionHandler(data, nil)
        }
    }
}

enum ImagesServicesError: Error {
    case fetchError
    case notFoundImage
    
    var description: String {
        switch self {
        case .fetchError:
            return "Error al obtener respuesta de Imagenes"
        case .notFoundImage:
            return "No se encontro imagen"
        }
    }
}
