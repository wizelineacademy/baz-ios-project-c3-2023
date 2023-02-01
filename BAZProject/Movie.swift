//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movies:Codable {
    let page: Int
    let results: [Results]
}

struct Results:Codable{
    let title : String
    let id: Int
}
