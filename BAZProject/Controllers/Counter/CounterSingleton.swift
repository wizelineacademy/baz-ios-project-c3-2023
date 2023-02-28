//
//  CounterSingleton.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 27/02/23.
//

class CounterSingleton {

    static var shared: CounterSingleton = {
        let instance = CounterSingleton()
        return instance
    }()
    
    private var counterMovies: Int = 0

    private init() {}

    func addToCounter() {
        counterMovies = counterMovies + 1
    }
    
    func returnMoviesCounter() -> String {
        return counterMovies.description
    }
}
