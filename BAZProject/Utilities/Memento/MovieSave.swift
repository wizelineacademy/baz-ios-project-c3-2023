//
//  MovieSave.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 16/02/23.
//

import Foundation

// MARK: - CareTaker
public class SaveMovies {
    let watchedMovies = "Watched-Movies"
    let favoriteMovies = "Favorite-Movies"
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    func save(_ movie: [Movie], title: String) throws {
        let data = try encoder.encode(movie)
        userDefaults.set(data, forKey: title)
    }
    
    func load(title: String) throws -> [Movie] {
        guard let data = userDefaults.data(forKey: title),
              let movie = try? decoder.decode([Movie].self, from: data)
        else {
            throw Error.dataNotFound
        }
        return movie
    }
    
    public enum Error: String, Swift.Error {
        case dataNotFound
    }
}
