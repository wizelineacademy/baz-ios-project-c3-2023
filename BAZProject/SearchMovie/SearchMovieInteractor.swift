//
//  SearchMovieInteractor.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation


class SearchMovieInteractor {
    //MARK: - Properties
    var presenter: SearchInteractorOutputProtocol?
    private let apiKey: String     = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let rootURL:String     = "https://api.themoviedb.org/3/search/multi"
    private let extraParams:String = "&language=es-MX"
    
    /// Nos permite crear la url con los parametros requeridos
    /// - Parameter query: Es la o las palabras a buscar por el API de Peliculas
    /// - Returns: Mps regresa un String con toda la URL formada
    func createURL(forQuery query: String? = nil) -> String {
        let strURL = "\(rootURL)\(apiKey)\(extraParams)&query=\(query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        return  strURL
    }
    
}

//MARK: - Extensions
extension SearchMovieInteractor: SearchInteractorInputProtocol {
    
    /// Esta funcion nos permite llamar el API de peliculas con un parametro de busqueda
    /// - Parameter query: Es el String a buscar en el API
    func fetchModel(with query: String) {
        guard let urlPath = URL(string: createURL(forQuery: query)) else {return}
        URLSession.shared.dataTask(with: urlPath){ data, response , error in
             if error == nil && data != nil {
                 let decoder = JSONDecoder()
                 do {
                    let pageResult = try decoder.decode(PageMoviesResult.self, from: data ?? Data())
                     self.presenter?.presentView(with: pageResult.results)
                 } catch  {
                     debugPrint("Hubo un error al parsear la información")
                 }
             }
         }.resume()
    }
}
