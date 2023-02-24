//
//  MovieDetailsModel.swift
//  BAZProject
//
//  Created by 1034209 on 23/02/23.
//

import Foundation

enum MovieDetails {
    enum LoadView {
        struct Response {
            var movie: MovieSearch
        }
        struct ViewModel {
            var title: String
        }
    }
}
