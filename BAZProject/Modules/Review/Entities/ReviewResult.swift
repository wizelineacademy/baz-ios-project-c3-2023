//  ReviewResult.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ReviewResult
struct ReviewResult: Codable {
    // TODO: Implement type logic or remove this type declaration if it is not needed
    var id: String?
    enum CodingKeys: String, CodingKey {
        case id = "ID"
    }
}
