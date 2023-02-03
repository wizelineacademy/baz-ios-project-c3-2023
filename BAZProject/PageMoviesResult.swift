//
//  PageResult.swift
//  BAZProject
//
//  Created by hlechuga on 01/02/23.
//

import Foundation

struct PageMoviesResult : Codable{
    let page:Int?
    let results:[Movie]?
    let total_pages:Int?
    let total_results:Int?
}
