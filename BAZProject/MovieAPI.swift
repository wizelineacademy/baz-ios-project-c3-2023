//
//  MovieAPI.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import Foundation
import UIKit

class MovieAPI{
    
    /// Get the movies from the API movies and parse the data to a dictionary array of type Movie
    ///
    /// - Parameter urlIdentifierMovie: String with the movie api url
    /// - Parameter completion: Escaping closure that escapes the movie dictionary array or a nil
    /// - Returns: escaping closure with the dictionary array of type Movie, if the parse fails, can return nil
    func getMovies(for urlIndentifierMovie: String, completion: @escaping ([Movie]?) -> Void){
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlIndentifierMovie),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
               let results = json.object(forKey: "results") as? [NSDictionary], results.count > 0 {
                do {
                    let movieData = try JSONSerialization.data(withJSONObject: results, options: [])
                    let movieDecode = try? JSONDecoder().decode([Movie].self, from: movieData)
                    let movies = movieDecode ?? [Movie]()
                    completion(movies)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getDetails(for urlIndentifierDetailMovie: String, completion: @escaping (DetailMovie?) -> Void){
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlIndentifierDetailMovie),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
                do {
                    let detailMovieData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let detailMovieDecode = try? JSONDecoder().decode(DetailMovie.self, from: detailMovieData)
                    let detailMovie = detailMovieDecode
                    completion(detailMovie)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getReviews(for urlIndentifierReviewMovie: String, completion: @escaping ([Reviews]?) -> Void){
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlIndentifierReviewMovie),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
               let results = json.object(forKey: "results") as? [NSDictionary], results.count > 0{
                do{
                    let reviewsData = try JSONSerialization.data(withJSONObject: results, options: [])
                    let reviewsDecode = try? JSONDecoder().decode([Reviews].self, from: reviewsData)
                    let reviews = reviewsDecode
                    completion(reviews)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func getCast(for urlIdentifierCastMovie: String, completion: @escaping ([Cast]?) -> Void){
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlIdentifierCastMovie),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
               let results = json.object(forKey: "cast") as? [NSDictionary], results.count > 0{
                do{
                    let castData = try JSONSerialization.data(withJSONObject: results, options: [])
                    let castDecode = try? JSONDecoder().decode([Cast].self, from: castData)
                    let cast = castDecode
                    completion(cast)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    /// Get an image from the API movies and convert the url to an UIImage
    ///
    /// - Parameter urlIdentifierImage: String with the image url
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: Escaping closure with the uiImage type, if the parse fails, can return nil
    func getImage(for urlIdentifierImage: String, completion: @escaping (UIImage?) -> Void) {
        let urlString = "https://image.tmdb.org/t/p/w500\(urlIdentifierImage)"
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString),
               let data = try? Data(contentsOf: url ),
               let image: UIImage = UIImage(data: data) {
                 completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
