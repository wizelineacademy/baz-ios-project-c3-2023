//  CacheManager.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 23/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CacheManager {
    static var shared: CacheManager = {
        let instance = CacheManager()
        return instance
    }()

    private init() {}

    private let cache: NSCache = NSCache<NSString, UIImage>()

    func saveImageInCache(id: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: id))
    }

    func getImageFromCache(strUrl: String) -> UIImage? {
        return cache.object(forKey: NSString(string: strUrl))
    }
}
