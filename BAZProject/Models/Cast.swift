//
//  Cast.swift
//  BAZProject
//
//  Created by Mario Arceo on 28/02/23.
//

import UIKit

struct Casting {
    
    let name: String
    var profile_path: String
    
    init(name: String, profile_path: String) {
        self.name = name
        self.profile_path = myUrls.imagePath.rawValue + profile_path
    }
}
