//
//  Movie.swift
//  BAZProject
//
//

import Foundation
import UIKit

struct Movie:Codable {
    let adult:Bool?
    let backdrop_path:String?
    let id: Int?
    let title: String?
    let original_language:String?
    let original_title:String?
    let overview:String?
    let poster_path: String?
    let media_type:String?
    let genre_ids:[Int]?
    let popularity:Double?
    let release_date:String?
    let video:Bool?
    let vote_average:Double?
    let vote_count:Int?
    var poster_Image : UIImage{
        let urlImage = "https://image.tmdb.org/t/p/w500\(poster_path ?? "")"
        guard let url = URL(string: urlImage) else { return UIImage() }
        return UIImage(data: try! Data(contentsOf: url))  ?? UIImage()
    }
}
