//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation
import UserNotifications

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
    private let rootURL:String     = "https://api.themoviedb.org/3"
    private let extraParams:String = "&language=es&region=MX&page=1"
    
    
    func getCredits(forIdMovie idMovie:Int, completion: @escaping (Credits) -> Void ) {
        guard let url = URL(string: createURL(forMovieDetail: .cast, idMovie: idMovie)) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let credits = try decoder.decode(Credits.self, from: data ?? Data())
                    completion(credits)
                }catch let decodingError as DecodingError {
                    switch decodingError {
                    case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
                        debugPrint(c.debugDescription)
                    @unknown default:
                        debugPrint(decodingError.localizedDescription)
                    }
                } catch {
                    debugPrint(error.localizedDescription )
                }
            }
        }.resume()
    }
    
    func getSimilarMovies(forIdMovie idMovie:Int, completion: @escaping (SimilarMovies) -> Void ) {
        guard let url = URL(string: createURL(forMovieDetail: .similar, idMovie: idMovie)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let similarMovies = try decoder.decode(SimilarMovies.self, from: data ?? Data())
                    completion(similarMovies)
                }catch let decodingError as DecodingError {
                    switch decodingError {
                    case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
                        debugPrint(c.debugDescription)
                    @unknown default:
                        debugPrint(decodingError.localizedDescription)
                    }
                } catch {
                    debugPrint(error.localizedDescription )
                }
            }
        }.resume()
    }
    
    func getRecomendation(forIdMovie idMovie:Int, completion: @escaping (SimilarMovies) -> Void ) {
        guard let url = URL(string: createURL(forMovieDetail: .recommendations , idMovie: idMovie)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let recomendationMovies = try decoder.decode(SimilarMovies.self, from: data ?? Data())
                    completion(recomendationMovies)
                }catch let decodingError as DecodingError {
                    switch decodingError {
                    case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
                        debugPrint(c.debugDescription)
                    @unknown default:
                        debugPrint(decodingError.localizedDescription)
                    }
                } catch {
                    debugPrint(error.localizedDescription )
                }
            }
        }.resume()
    }
    
    func getReviews(forIdMovie idMovie:Int, completion: @escaping (Reviews) -> Void ) {
        guard let url = URL(string: createURL(forMovieDetail: .reviews , idMovie: idMovie)) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let reviews = try decoder.decode(Reviews.self, from: data ?? Data())
                    completion(reviews)
                }catch let decodingError as DecodingError {
                    switch decodingError {
                    case .typeMismatch(_, let c), .valueNotFound(_, let c), .keyNotFound(_, let c), .dataCorrupted(let c):
                        debugPrint(c.debugDescription)
                    @unknown default:
                        debugPrint(decodingError.localizedDescription)
                    }
                } catch {
                    debugPrint(error.localizedDescription )
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
    
    func fetchModel(with movie: Movie) {
        var movieModel: MovieDetail?
        let movieId = movie.id ?? 0
        getCredits(forIdMovie: movieId) { credits in
            self.getSimilarMovies(forIdMovie: movieId) { similarMovies in
                self.getRecomendation(forIdMovie: movieId) { recomendationMovies in
                    self.getReviews(forIdMovie: movieId) { reviews in
                        movieModel = MovieDetail(movie: movie,
                                                 credits: credits,
                                                 reviews: reviews,
                                                 similarMovies: similarMovies,
                                                 recomendtions: recomendationMovies)
                        guard let model = movieModel else { return }
                        self.presenter?.presentView(model: model)
                    }
                    
                }
            }
        }
        
    }
}
