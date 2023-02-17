//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation

enum URLMovieDetails: String {
    case reviews            = "/reviews"
    case similar            = "/similar"
    case recommendations    = "/recommendations"
    case cast               = "/credits"
    public var url: String { return rawValue }
    public var description: String{
        switch self {
        case .reviews:
            return "COMENTARIOS"
        case .similar:
            return "SIMILARES"
        case .recommendations:
            return "RECOMENDACIONES"
        case .cast:
            return "ACTORES"
        }
    }
}

class MovieDetailInteractor {
    
    //MARK: - Properties
    private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let rootURL:String     = "https://api.themoviedb.org/3/movie/"
    private let extraParams:String = "&language=es&region=MX&page=1"
    
    
    func createURL(forMovieDetail typeDetail: URLMovieDetails, idMovie: Int) -> String {
        let strURL = "\(rootURL)/movie/\(idMovie)\(typeDetail.url)\(apiKey)\(extraParams)"
        return  strURL
    }
    
    
}
