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
    var presenter: MovieDetailInteractorOutputProtocol?
    
    private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let rootURL:String     = "https://api.themoviedb.org/3/movie/"
    private let extraParams:String = "&language=es&region=MX&page=1"
    
    
    func getCredits(forIdMovie idMovie:Int, urlDetail:URLMovieDetails, completion: @escaping (Credits) -> Void ){
        guard let url = URL(string: createURL(forMovieDetail: urlDetail, idMovie: idMovie)) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    let credits = try decoder.decode(Credits.self, from: data ?? Data())
                    completion(credits)
                }catch{
                    
                }
            }
        }.resume()
    }
    
    /// Nos permite crear la url con los parametros requeridos
    /// - Parameter query: Es la o las palabras a buscar por el API de Peliculas
    /// - Returns: Mps regresa un String con toda la URL formada
    func createURL(forMovieDetail typeDetail: URLMovieDetails, idMovie: Int) -> String {
        let strURL = "\(rootURL)/movie/\(idMovie)\(typeDetail.url)\(apiKey)\(extraParams)"
        return  strURL
    }
    
    
}


//extension
extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    func fetchModel() {
        let movieModel = Movie(adult: true,
                               backdropPath: "",
                               id: 3, title: "Prueba",
                               originalLanguage: "",
                               originalTitle: "prueba",
                               overview: "", posterPath: "",
                               mediaType: "",
                               genreIds:[],
                               popularity: 4.3,
                               releaseDate: "",
                               video: false,
                               voteAverage: 4.4,
                               voteCount: 3)
        presenter?.presentView(model: movieModel)
    }
    
    
}
