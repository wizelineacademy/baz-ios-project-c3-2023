//
//  MovieAPI.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import Foundation
import UIKit

class MovieAPI{
    
    func getMovies(for urlIndentifierMovie: String, completion: @escaping ([Movie]?) -> Void){
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlIndentifierMovie),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
               let results = json.object(forKey: "results") as? [NSDictionary], results.count > 0{
                do{
                    let movieData = try JSONSerialization.data(withJSONObject: results, options: [])
                    let movieDecode = try? JSONDecoder().decode([Movie].self, from: movieData)
                    let movies = movieDecode ?? [Movie]()
                    completion(movies)
                }catch{
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }
    }

    func getImage(for urlIdentifierImage: String, completion: @escaping (UIImage?) -> Void) {
        let urlString = "https://image.tmdb.org/t/p/w500\(urlIdentifierImage)"
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString),
               let data = try? Data(contentsOf: url ),
               let image: UIImage = UIImage(data: data){
                 completion(image)
            }else{
                completion(nil)
            }
        }
    }
}
