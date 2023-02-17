//
//  SearchMovieInteractor.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation


class SearchMovieInteractor {
    //https://api.themoviedb.org/3/search/multi?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es-MX&query=pedro%20infante
    //MARK: - Properties
    private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let rootURL:String     = "https://api.themoviedb.org/3/search/multi"
    private let extraParams:String = "&language=es-MX"
    
    func createURL(forQuery query: String? = nil) -> String {
        let strURL = "\(rootURL)\(apiKey)\(extraParams)&query=\(query ?? "")"
        return  strURL
    }
    
}
