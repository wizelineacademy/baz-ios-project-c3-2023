//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {
    func getMovies(url:String, handler: @escaping (Data) -> Void){
        guard let url = URL(string: url) else{return}
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datos = data else{return}
            handler(datos)
        }
        task.resume()
    }
}
