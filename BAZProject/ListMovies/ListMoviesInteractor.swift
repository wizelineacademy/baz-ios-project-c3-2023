//
//  ListMoviesInteractor.swift
//  BAZProject
//
//  Created by hlechuga on 02/02/23.
//

import Foundation

    //MARK:- MovieAPIURLs
    enum TypeOfMovies: String {
        case trending           = "/trending/movie/day"
        case nowPlaying         = "/movie/now_playing"
        case popular            = "/movie/popular"
        case topRated           = "/movie/top_rated"
        case upcoming           = "/movie/upcoming"
        public var url: String { return rawValue }
        var description: String{
            switch self{
            case .trending:
                return "TRENDING"
            case .nowPlaying:
                return "NOW PLAYING"
            case .popular:
                return "POPULAR"
            case .topRated:
                return "TOP RATED"
            case .upcoming:
                return "PRÓXIMOS"
            }
        }
    }

class ListMoviesInteractor {

        //MARK:- Private Params
        private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        private let rootURL:String     = "https://api.themoviedb.org/3"
        private let extraParams:String = "&language=es&region=MX&page=1"
        var allMoviesTypes: [AllMovieTypes] = []

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
       func getMovies(forType typeOfMovies:TypeOfMovies, completion: @escaping (PageMoviesResult) -> Void){
           if let urlPath = URL(string: createURL(forType: typeOfMovies)){
               URLSession.shared.dataTask(with: urlPath){ data, response , error in
                    if error == nil && data != nil {
                        let decoder = JSONDecoder()
                        do {
                           let pageResult = try decoder.decode(PageMoviesResult.self, from: data ?? Data())
                            completion(pageResult)
                        } catch  {
                            debugPrint("Hubo un error al parsear la información")
                        }
                    }
                }.resume()
           }
        }
    
    /**
    Esta función permite traer el modelo  con las peliculas  en una sola llamada:
         * trending
         * nowPlaying
         * popular
         * topRated
         * upcoming
    :condiciones:
    :param:
    :returns: @escaping listado de peliculas [AllMovieTypes]
    */
    func getMoviesAllCategories(completion: @escaping ([AllMovieTypes]) -> Void){
        var arrAllCategories: [AllMovieTypes] = []
        getMovies(forType: .trending) { trendingMovies in
            arrAllCategories.append(AllMovieTypes(typeOfMovies: .trending, pagesMovies: trendingMovies))
            self.getMovies(forType: .nowPlaying) { nowPlayingMovies in
                arrAllCategories.append(AllMovieTypes(typeOfMovies: .nowPlaying, pagesMovies: nowPlayingMovies))
                self.getMovies(forType: .popular) { popularMovies in
                    arrAllCategories.append(AllMovieTypes(typeOfMovies: .popular, pagesMovies: popularMovies))
                    self.getMovies(forType: .topRated) { topRatedMovies in
                        arrAllCategories.append(AllMovieTypes(typeOfMovies: .topRated, pagesMovies: topRatedMovies))
                        self.getMovies(forType: .upcoming) { upcomingMovies in
                            arrAllCategories.append(AllMovieTypes(typeOfMovies: .upcoming, pagesMovies: upcomingMovies))
                            completion(arrAllCategories)
                        }
                    }
                }
            }
        }
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
            }
            return  strURL
        }

    }
