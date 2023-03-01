//  TrendingModel.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 28/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct TrendingModel {
    var id: Int
    var mediaTitle: String
    var backdropPath: String

    init(with data: MovieResult) {
        self.id = data.id ?? .zero
        self.mediaTitle = data.title ?? ""
        self.backdropPath = data.backdropPath ?? ""
    }
}
