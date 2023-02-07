//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

//MARK:- MovieAPIURLs
enum TypeOfMovies: String {
    case trending           = "/trending/movie/day"
    case nowPlaying         = "/movie/now_playing"
    case popular            = "/movie/popular"
    case topRated           = "/movie/top_rated"
    case upcoming           = "/movie/upcoming"
    case keyword            = "/search/keyword"
    case search             = "/search/movie"
    case reviews            = "/reviews"
    case similar            = "/similar"
    case recommendations    = "/recommendations"
    public var url: String { return rawValue }
}

class MovieAPI {

    //MARK:- Private Params
    private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let rootURL:String     = "https://api.themoviedb.org/3"
    private let extraParams:String = "&language=es&page=1"

    /**
    Esta función permite traer un listado de peliculas dependiendo de los parametros de búsqueda.

    :condiciones: Es importante tener en cuenta que tipo de peliculas quieres mostrar:
        * trending
        * nowPlaying
        * popular
        * topRated
        * upcoming
    :param: enum TypeOfMovies
    :returns: @escaping listado de peliculas [Movie]
    */
   func getMovies(forType typeOfMovies:TypeOfMovies, completion : @escaping (PageMoviesResult) -> Void ) {
        guard let urlPath = URL(string: createURL(forType: typeOfMovies)) else {
            debugPrint("La URL esta mal")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlPath){ data, response , error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                   let resultPage = try decoder.decode(PageMoviesResult.self, from: data ?? Data())
                   completion(resultPage)
                } catch  {
                    debugPrint("Hubo un error al parsear la información")
                }
            }
        }
        dataTask.resume()
    }
    
    /**
    Esta función permite crear la URL que nos permitira hacer la búsqueda de las peliculas.
    :condiciones: Es importante tener en cuenta que tipo de peliculas quieres mostrar con su respectivas caracteristicas
    :param: enum TypeOfMovies para determinar si tipo idMovie: Int si es que se quiere una pelicula en particular, query : String si se requiere buscar una palabra en particular
    :returns: @escaping listado de peliculas [Movie]
    */
    func createURL(forType typeOfMovies: TypeOfMovies, idMovie: Int? = nil, query: String? = nil) -> String {
        var strURL = ""
        switch typeOfMovies {
        case .trending , .nowPlaying, .popular, .topRated, .upcoming:
            strURL = "\(rootURL)\(typeOfMovies.url)\(apiKey)\(extraParams)"
        case .keyword , .search:
            strURL = "\(rootURL)\(typeOfMovies.url)\(apiKey)\(extraParams)&query=\(query ?? "")"
        case .reviews, .similar, .recommendations :
            strURL = "\(rootURL)/movie/\(idMovie ?? 505642)\(typeOfMovies.url)\(apiKey)\(extraParams)"
        }
        return  strURL
    }

}
